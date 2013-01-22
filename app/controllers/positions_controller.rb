class PositionsController < ApiController
  def index
    @positions = current_user.positions

    respond_with @positions
  end
end