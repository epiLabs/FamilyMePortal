class Api::V1::FamiliesController < ApiController
  def show
    @family = current_user.family

    unless @family
      render json: {error: "You are not part of a family"}, :status => 404
    end
  end
end