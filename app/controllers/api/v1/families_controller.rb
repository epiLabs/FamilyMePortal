class Api::V1::FamiliesController < ApplicationController
  before_filter :authenticate_user!
  
  def show
  end
end