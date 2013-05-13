class TaskListsController < ApplicationController
  before_filter :ensure_user_is_authenticated
  before_filter :ensure_user_is_in_a_family

  def index
    @task_lists = current_user.family.task_lists
  end

  def show
    @task_list =  current_user.family.task_lists.find(params[:id])
  end

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(params[:task_list])
    @task_list.family = current_user.family
    @task_list.author = current_user

    if @task_list.save
      redirect_to @task_list, notice: 'Task list was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @task_list = current_user.task_lists.find(params[:id])

    if @task_list.update_attributes(params[:task_list])
      redirect_to @task_list, notice: 'Task list was successfully updated.'
    else
      render action: "edit"
    end
  end

  def edit
    @task_list = TaskList.find(params[:id])
  end

  def destroy
    current_user.family.task_lists.find(params[:id]).destroy

    redirect_to task_lists_url
  end
end
