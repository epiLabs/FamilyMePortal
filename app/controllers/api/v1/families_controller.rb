class Api::V1::FamiliesController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @family = current_user.family

    if @family
      render json: "IT WORKS"
    else
      render json: {error: "You are not part of a family"}, :status => 404
    end
  end
end