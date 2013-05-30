require 'spec_helper'

describe Api::V1::EventsController do
  before :all do
    Time.zone = "Paris"
  end

  before :each do
    @user = FactoryGirl.create :user
    @family = Family.generate_new_including_user(@user)

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

    describe "given there are 3 events already created" do
      it "loads all the existing events" do
        event_1 = FactoryGirl.create :event, user: @user, family: @family
        event_2 = FactoryGirl.create :event, user: @user, family: @family
        event_3 = FactoryGirl.create :event, user: @user, family: @family

        expect(assigns(:events)).to match_array([event_1, event_2, event_3])
      end
    end

    describe "without any event" do
      it "should load an empty array" do
        expect(assigns(:events)).to match_array([])
      end
    end
  end

  describe "POST #create" do
    describe 'when using valid start and end dates' do
      before :each do
        @begin = Time.zone.now
        @end = Time.zone.now + 2.hours
        post :create, event: {start_date: @begin, end_date: @end, title: "Some event"}
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "should render the show template" do
        expect(response).to render_template("show")
      end

      it "creates the event successfuly" do
        # binding.pry
        expect(@user.events.last.start_date.to_s).to eq @begin.to_s
        expect(@user.events.last.end_date.to_s).to eq @end.to_s
      end
    end

    describe 'without parameters' do
      it "responds successfully with an HTTP 400 status code" do
        post :create
        expect(response.status).to eq(400)
      end
    end

    describe 'without end date' do
      before :each do
        post :create, event: {start_date: Time.now, title: "No end date"}
      end

      it "responds successfully with an HTTP 400 status code" do
        expect(response.status).to eq(400)
      end
    end
  end

  describe "given a event 'courses' already exist" do
    before :each do
      @event = FactoryGirl.create :event, title: "courses", family: @family, user: @user
    end

    describe "DELETE #destroy" do
      before :each do
        delete :destroy, id: @event.id
      end
      
      it "should delete my event" do
        expect(Event.find_by_id(@event.id)).to be nil
      end
    end

    describe "PUT #update" do

      describe "I update the name of my event to 'Lidl time'" do
        before :each do
          put :update, {id: @event.id, event: {title: 'Lidl time'}}
        end

        it "returns a 200 status code and the update event" do
          expect(response.status).to eq(200)
          expect(assigns[:event].title).to eq 'Lidl time'
        end
  
        it "should render the show template" do
          expect(response).to render_template("show")
        end
      end

      describe "I try to update the title with an invalid one" do
        before :each do
          put :update, {id: @event.id, event: {title: ' b    '}}
        end

        it "returns an HTTP 400 status code" do
          expect(response.status).to eq(400)
        end
      end
    end

    describe "GET #show" do
      it "should show me the event 'courses' when I get its page" do
        get :show, id: @event.id

        expect(response.status).to eq(200)
        expect(assigns[:event].title).to eq @event.title
      end
    end
  end

  describe "given there is a past, a present and a future event" do
    before :each do
      @old = FactoryGirl.create :event, family: @family, start_date: 3.weeks.ago, end_date: 2.weeks.ago, title: "The past"
      @current = FactoryGirl.create :event, family: @family, start_date: 1.hour.ago, end_date: (Time.now + 3.hours), title: "The present"
      @incoming = FactoryGirl.create :event, family: @family, start_date: (Time.now + 5.hours), end_date: (Time.now + 6.hours), title: "The Future"
    end

    describe "GET #currents" do
      before :each do
        get :currents
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end

      it "should render the current and incoming events" do
        expect(assigns(:events)).to match_array([@current, @incoming])
      end
    end
  end
end
