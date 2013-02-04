class Api::V1::PositionsController < ApiController
  def index
    @positions = current_user.positions
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