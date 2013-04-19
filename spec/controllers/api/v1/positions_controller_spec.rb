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
  end
end
