class UsersController < ApiController
  def index
    @users = current_user.family.users
  end  
end