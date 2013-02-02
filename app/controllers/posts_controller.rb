class PostsController < ApiController
  def index
    @posts = current_user.family.posts
    respond_with @posts
  end

  def destroy
    respond_with current_user.posts.find(params[:id]).destroy
  end

  def create
    @post = current_user.posts.new(params[:post])
    @post.family = current_user.family
    
    if @post.save
      render 'show'
    else
      render json: {error: @post.errors}, status: 400
    end
  end
end