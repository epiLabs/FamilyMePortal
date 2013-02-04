class Api::V1::PostsController < ApiController
  def index
    if current_user.family
      @posts = current_user.family.posts

      respond_with @posts
    else
      render json: {error: "You are not part of a family"}, status: 400
    end
  end

  def destroy
    respond_with current_user.posts.find(params[:id]).destroy
  end

  def create
    @post = current_user.posts.new(params[:post])
    @post.family = current_user.family
    
    unless @post.save
      render json: {error: @post.errors}, status: 400
    end
  end
end