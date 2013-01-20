class Api::V1::FamiliesController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!
  
  def show
    @family = current_user.family

    unless @family
      render json: {error: "You are not part of a family"}, :status => 404
    end
  end
end