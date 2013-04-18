class Api::V1::FamiliesController < ApiController
  def show
    @family = current_user.family
  end
end
