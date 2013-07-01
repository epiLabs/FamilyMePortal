class Api::V1::PostsController < ApiController
  def index
    @posts = current_user.family.posts
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

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(params[:post])
      render action: :create
    else
      render json: {error: @post.errors}, status: 400
    end
  end
end
