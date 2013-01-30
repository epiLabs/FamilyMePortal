class PostsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  respond_to :html, :only => :index

  def index
    @user = current_user
    @posts = @user.family.posts
    respond_with @posts
  end
end