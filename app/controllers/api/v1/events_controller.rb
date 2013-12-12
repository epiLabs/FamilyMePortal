class Api::V1::EventsController < ApiController
  def destroy
    @event = current_user.family.events.find(params[:id])
    @event.destroy

    render nothing: true, head: :no_content
  end

  def create
    @event = current_user.family.events.new(params[:event])
    @event.user = current_user

    if @event.save
      render action: :show
    else
      render json: {error: @event.errors}, status: 400
    end
  end

  def update
    @event = current_user.family.events.find(params[:id])

    if @event.update_attributes(params[:event])
      render action: :show
    else
      render json: {error: @event.errors}, status: 400
    end
  end

  def show
    @event = current_user.family.events.find(params[:id])
  end

  def index
    @events = current_user.family.events
  end

  def currents
    @events = current_user.family.events.currents_and_futures.order('start_date')

    render :index
  end
end
