require 'spec_helper'

describe Api::V1::PositionsController do

  before :each do
    @user = FactoryGirl.create :user
    Family.generate_new_including_user(@user)

    sign_in :user, @user
  end

  describe "GET #index" do
    describe 'when I want to retrieve my positions' do
      before :each do
        get :index

        @position_1 = FactoryGirl.create :position, :valid_coordinates, user: @user
        @position_2 = FactoryGirl.create :position, :valid_coordinates, user: @user
        @position_3 = FactoryGirl.create :position, :valid_coordinates, user: @user
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end

      it "loads all the positions that I have already checked out" do
        expect(assigns(:positions)).to match_array([@position_1, @position_2, @position_3])
      end
    end

    describe "given an user named 'Chris' with two positions" do
      before :each do
        @chris = FactoryGirl.create :user, nickname: 'Chris', family: @user.family

        @position_1 = FactoryGirl.create :position, :valid_coordinates, user: @chris
        @position_2 = FactoryGirl.create :position, :valid_coordinates, user: @chris
      end

      describe "when I Chris's user_id as parameter" do
        before  :each do
          get :index, user_id: @chris.id
        end

        it "returns the two positions that Chris as checked in" do
          expect(assigns(:positions).count).to be 2
          expect(assigns(:positions)).to match_array([@position_1, @position_2])
        end
      end
    end
  end

  describe "POST #create" do
    describe 'when using valid coordinates' do
      before :each do
        post :create, position: {latitude: 10, longitude: 25}
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "creates the position successfuly" do
        position = Position.find(JSON.parse(response.body)['id'])
        expect(@user.positions.last).to eq position
      end
    end

    describe 'without coordinates' do
      it "responds successfully with an HTTP 400 status code" do
        post :create
        expect(response.status).to eq(400)
      end
    end

    describe 'when using invalid coordinates' do
      before :each do
        post :create, position: {latitude: -987223, longitude: 24}
      end

      it "responds successfully with an HTTP 400 status code" do
        expect(response.status).to eq(400)
      end
    end

    describe 'given a position (42.2315, -32.1124) already exists' do
      before :each do
        post :create, position: {latitude: 42.2315, longitude: -32.1124}
        @original_position_id = JSON.parse(response.body)['id']
        @original_position = Position.find(@original_position_id)
      end

      describe 'when checking out a position very close to the previous one' do
        before :each do
          post :create, position: {latitude: 42.2316, longitude: -32.11245}
        end

        it "doesn't create the position but returns the previous one" do
          expect(response.status).to eq 200
          expect(JSON.parse(response.body)['id']).to eq @original_position_id
        end

        it "updates the updated_at field of the last position" do
          @original_position.updated_at.should_not be JSON.parse(response.body)['updated_at']
        end
      end

      describe 'when checking out a position far from the previous' do
        before :each do
          post :create, position: {latitude: 42.999, longitude: -32.421}
        end

        it "successfully creates the position" do
          expect(response.status).to eq 200
          expect(JSON.parse(response.body)['id']).not_to be @original_position_id
        end        
      end
    end
  end

  describe "GET #latest" do
    describe 'given there are no position checked out' do
      it 'responds successfully with an HTTP 200 status code and returns an empty array' do
        get :latest

        expect(response).to be_success
        expect(response.status).to eq(200)
        expect(assigns(:positions).count).to be 0
      end
    end

    describe 'given that we are 4 in my family' do
      before :each do
        @jean = FactoryGirl.create :user, nickname: 'Jean', family: @user.family
        @first_position_jean = FactoryGirl.create :position, :valid_coordinates, user: @jean
        @last_position_jean = FactoryGirl.create :position, :valid_coordinates, user: @jean

        @simon = FactoryGirl.create :user, nickname: 'Simon', family: @user.family
        @last_position_simon = FactoryGirl.create :position, :valid_coordinates, user: @simon

        @ben = FactoryGirl.create :user, nickname: 'Ben', family: @user.family
        @first_position_ben = FactoryGirl.create :position, :valid_coordinates, user: @ben
        @last_position_ben = FactoryGirl.create :position, :valid_coordinates, user: @ben

        get :latest
      end

      describe "When I didn't checked out any position and the others did" do
        it "returns an array containing 3 elements" do
          expect(assigns(:positions).count).to be 3
          expect(assigns(:positions)).to match_array([@last_position_jean, @last_position_simon, @last_position_ben])
        end
      end
    end
  end
end
