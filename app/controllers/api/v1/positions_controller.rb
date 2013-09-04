class Api::V1::PositionsController < ApiController
  def index
    if params[:user_id]
      @positions = current_user.family.users.find(params[:user_id]).positions
    else
      @positions = current_user.positions
    end
  end

  def latest
    @positions = []
    current_user.family.users.each do |user|
      position = user.positions.last
      @positions << position if position.present?
    end
    
    render :index
  end

  # This method avoid checking out duplicates by checking the last position and returning
  # it if the coords are identical
  def create
    last_position = current_user.positions.last
    @position = current_user.positions.new(params[:position])

    if last_position && last_position.latitude.round(3) == @position.latitude.round(3) && last_position.longitude.round(3) == @position.longitude.round(3)
      @position = last_position
      @position.touch :updated_at # Update the updated_at field
    end

    if @position.save
      render json: @position, status: 200
    else
      render json: {error: @position.errors}, status: 400
    end
  end
end
