class UsersController < ApplicationController
  before_filter :ensure_user_is_authenticated
  before_filter :ensure_user_is_in_a_family

  def index
    @users = current_user.family.users
  end

  def show
  end
end
