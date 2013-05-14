class Api::V1::TaskListsController < ApiController
  def destroy
    @task_list = current_user.family.task_lists.find(params[:id])
    @task_list.destroy

    render nothing: true, head: :no_content
  end

  def create
    @task_list = current_user.family.task_lists.new(params[:task_list])
    @task_list.author = current_user
    
    if @task_list.save
      render action: :show
    else
      render json: {error: @task_list.errors}, status: 400
    end
  end

  def update
    @task_list = current_user.family.task_lists.find(params[:id])

    if @task_list.update_attributes(params[:task_list])
      render action: :show
    else
      render json: {error: @task_list.errors}, status: 400
    end
  end

  def show
    @task_list = current_user.family.task_lists.find(params[:id])
  end

  def index
    @task_lists = current_user.family.task_lists
  end
end
