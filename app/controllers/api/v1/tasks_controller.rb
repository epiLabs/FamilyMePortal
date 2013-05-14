class Api::V1::TasksController < ApiController
  before_filter :fetch_task_list

  def fetch_task_list
    @task_list = current_user.family.task_lists.find(params[:task_list_id])
  end

  def destroy
    @task = @task_list.tasks.find(params[:id])
    @task.destroy

    render nothing: true, head: :no_content
  end

  def create
    @task = @task_list.tasks.new(params[:task])
    
    if @task.save
      render action: :show
    else
      render json: {error: @task.errors}, status: 400
    end
  end

  def update
    @task = @task_list.tasks.find(params[:id])

    if @task.update_attributes(params[:task])
      render action: :show
    else
      render json: {error: @task.errors}, status: 400
    end
  end

  def show
    @task = @task_list.tasks.find(params[:id])
  end

  def index
    @tasks = @task_list.tasks
  end

  def finish
    @task = @task_list.tasks.find(params[:id])
    @task.finish! params[:cancel]

    render action: :show
  end
end
