require 'spec_helper'

describe Api::V1::TasksController do
  before :each do
    @user = FactoryGirl.create :user
    @family = Family.generate_new_including_user(@user)
    @task_list = FactoryGirl.create :task_list, family: @family, author: @user
    sign_in :user, @user
  end

  describe "GET #index" do
    before :each do
      get :index, task_list_id: @task_list.id
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    describe "given there are 3 tasks already created" do
      before :each do
        @task_1 = FactoryGirl.create :task, title: "My first task", task_list: @task_list
        @task_2 = FactoryGirl.create :task, title: "My second task", task_list: @task_list
        @task_3 = FactoryGirl.create :task, title: "My third task", task_list: @task_list
      end

      it "loads all the existing tasks" do
        expect(assigns(:tasks)).to match_array([@task_1, @task_2, @task_3])
      end
    end

    describe "without any task" do
      it "should load an empty array" do
        expect(assigns(:tasks)).to match_array([])
      end
    end
  end

  describe "POST #create" do
    describe 'when using valid title "A good title"' do
      before :each do
        post :create, task_list_id: @task_list.id, task: {title: "A good title"}
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "should render the show template" do
        expect(response).to render_template("show")
      end

      it "creates the task successfuly" do
        expect(@task_list.tasks.last.title).to eq "A good title"
      end
    end

    describe 'without title' do
      it "responds successfully with an HTTP 400 status code" do
        post :create, task_list_id: @task_list.id
        expect(response.status).to eq(400)
      end
    end

    describe 'when using an invalid title' do
      before :each do
        post :create, task_list_id: @task_list.id, task: {title: "        "}
      end

      it "responds successfully with an HTTP 400 status code" do
        expect(response.status).to eq(400)
      end
    end

    describe 'given a task "Some random task" already exists' do
      before :each do
        @other_task = FactoryGirl.create :task, title: "Some random task", task_list: @task_list
      end

      it "shouldn't allow me to create another task named '   Some random task'" do
        post :create, task_list_id: @task_list.id, task: {title: "   Some random task"}
        expect(response.status).to eq(400)
      end
    end

    describe "given I create a task 'Learn chinese' and assign myself" do
      before :each do
        post :create, task_list_id: @task_list.id, task: {title: "Learn chinese", user_id: @user}
      end

      it "should create the task successfully" do
        expect(response.status).to eq(200)
      end

      it "should be listed in my assigned tasks" do
        expect(@user.assigned_tasks.last.title).to eq "Learn chinese"
      end
    end
  end

  describe "given a task 'Go to bed' already exist" do
    before :each do
      @task = FactoryGirl.create :task, title: "Go to bed", task_list: @task_list
    end

    describe "DELETE #destroy" do
      before :each do
        delete :destroy, task_list_id: @task_list.id, id: @task.id
      end
      
      it "should delete my task" do
        expect(Task.find_by_id(@task.id)).to be nil
      end
    end

    describe "PUT #update" do

      describe "I update the name of my task to 'Go to dublin'" do
        before :each do
          put :update, task_list_id: @task_list.id, id: @task.id, task: {title: 'Go to dublin'}
        end

        it "returns a 200 status code and the update task" do
          expect(response.status).to eq(200)
          expect(assigns[:task].title).to eq 'Go to dublin'
        end
  
        it "should render the show template" do
          expect(response).to render_template("show")
        end
      end

      describe "I try to update the name with an invalid one" do
        before :each do
          # only 3 characters
          put :update, task_list_id: @task_list.id, id: @task.id, task: {title: '    BAD  '}
        end

        it "returns an HTTP 400 status code" do
          expect(response.status).to eq(400)
        end
      end
    end

    describe "GET #show" do
      it "should show me the task list 'Go to bed' when I get its page" do
        get :show, task_list_id: @task_list.id, id: @task.id

        expect(response.status).to eq(200)
        expect(assigns[:task].title).to eq @task.title
      end
    end

    describe "GET #finish" do
      describe "when I call it without parameters" do
        before :each do
          get :finish, task_list_id: @task_list.id, id: @task.id
        end

        it "returns an HTTP 200 status code" do
           expect(response.status).to eq(200)
        end

        it "change the status of my task to finished" do
          @task.reload

          expect(@task.finished).to eq true
        end
      end

      describe "given my task is already finished" do
        before :each do
          @task.finish!
        end

        describe "I send a parameter cancel" do
          before :each do
            get :finish, task_list_id: @task_list.id, id: @task.id, cancel: true
          end

          it "returns an HTTP 200 status code" do
             expect(response.status).to eq(200)
          end
          
          it "change the status of my task to not finished" do
            @task.reload

            expect(@task.finished).to eq false
          end
        end
      end
    end
  end
end
