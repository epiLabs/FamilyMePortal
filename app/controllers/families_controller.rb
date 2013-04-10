class FamiliesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :welcome]

  def show
    unless user_signed_in?
      redirect_to news_index_path
      return
    end

    @user = current_user
    @family = current_user.family
  end

  def create
    @family = Family.generate_new_including_user current_user

    redirect_to action: :show
  end

  def update
  end

  def welcome
  end
end
