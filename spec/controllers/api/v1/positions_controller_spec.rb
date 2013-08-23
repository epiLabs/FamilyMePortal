require 'spec_helper'

describe Api::V1::PositionsController do

  before :each do
    @user = FactoryGirl.create :user
    Family.generate_new_including_user(@user)

    sign_in :user, @user
  end

  describe "GET #index" do
    before :each do
      get :index
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "loads all the positions that I have already checked out" do
      position_1 = FactoryGirl.create :position, :valid_coordinates, user: @user, latitude: 25
      position_2 = FactoryGirl.create :position, :valid_coordinates, user: @user, latitude: 10
      position_3 = FactoryGirl.create :position, :valid_coordinates, user: @user, latitude: 30

      expect(assigns(:positions)).to match_array([position_1, position_2, position_3])
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
      end

      describe 'when checking out a position very close to the previous one' do
        before :each do
          post :create, position: {latitude: 42.2316, longitude: -32.11245}
        end

        it "doesn't create the position but returns the previous one" do
          expect(response.status).to eq 200
          expect(JSON.parse(response.body)['id']).to eq @original_position_id
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
end
