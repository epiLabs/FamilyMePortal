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

  def create
    @position = current_user.positions.new(params[:position])

    if @position.save
      render json: @position, status: 200
    else
      render json: {error: @position.errors}, status: 400
    end
  end
end
