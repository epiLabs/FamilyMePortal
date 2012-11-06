class FamiliesController < ApplicationController
  before_filter :authenticate_user!, except: :index

  def index
    redirect_to :controller => 'news', :action => 'index' unless user_signed_in?
  end

  def show
  end
end
