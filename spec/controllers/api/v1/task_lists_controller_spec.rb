require 'spec_helper'

describe Api::V1::TaskListsController do
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

    describe "given there are 3 task lists already created" do
      it "loads all the existing task lists" do
        task_lists_1 = FactoryGirl.create :task_list, author: @user, family: @family
        task_lists_2 = FactoryGirl.create :task_list, author: @user, family: @family
        task_lists_3 = FactoryGirl.create :task_list, author: @user, family: @family

        expect(assigns(:task_lists)).to match_array([task_lists_1, task_lists_2, task_lists_3])
      end
    end

    describe "without any task list" do
      it "should load an empty array" do
        expect(assigns(:task_lists)).to match_array([])
      end
    end
  end

  describe "POST #create" do
    describe 'when using valid title "A good title"' do
      before :each do
        post :create, task_list: {title: "A good title"}
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "should render the show template" do
        expect(response).to render_template("show")
      end

      it "creates the task list successfuly" do
        expect(@user.task_lists.last.title).to eq "A good title"
      end
    end

    describe 'without title' do
      it "responds successfully with an HTTP 400 status code" do
        post :create
        expect(response.status).to eq(400)
      end
    end

    describe 'when using an invalid title' do
      before :each do
        post :create, taks_list: {title: "        "}
      end

      it "responds successfully with an HTTP 400 status code" do
        expect(response.status).to eq(400)
      end
    end
  end

  describe "given a task list 'courses' already exist" do
    before :each do
      @task_list = FactoryGirl.create :task_list, title: "courses", family: @family, author: @user
    end

    describe "given my task list a task on it" do
      before :each do
        @task = FactoryGirl.create :task, :valid, task_list: @task_list
      end
        
      describe "DELETE #destroy" do
        before :each do
          delete :destroy, id: @task.id
        end
        
        it "should delete my task list" do
          expect(TaskList.find_by_id(@task_list.id)).to be nil
        end

        it "should delete the task on it" do
          expect(Task.find_by_id(@task.id)).to be nil
        end
      end
    end

    describe "PUT #update" do

      describe "I update the name of my list to 'Lidl time'" do
        before :each do
          put :update, {id: @task_list.id, task_list: {title: 'Lidl time'}}
        end

        it "returns a 200 status code and the update task list" do
          expect(response.status).to eq(200)
          expect(assigns[:task_list].title).to eq 'Lidl time'
        end
  
        it "should render the show template" do
          expect(response).to render_template("show")
        end
      end

      describe "I try to update the name with an invalid one" do
        before :each do
          put :update, {id: @task_list.id, task_list: {title: ' bad    '}}
        end

        it "returns an HTTP 400 status code" do
          expect(response.status).to eq(400)
        end
      end
    end

    describe "GET #show" do
      it "should show me the task list 'courses' when I get its page" do
        get :show, id: @task_list.id

        expect(response.status).to eq(200)
        expect(assigns[:task_list].title).to eq @task_list.title
      end
    end
  end
end
