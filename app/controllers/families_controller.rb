class FamiliesController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def go_to_family_homepage
    redirect_to 'show'
  end

  def show
    unless user_signed_in?
      redirect_to news_index_path
      return
    end
    
    @family = current_user.family
  end

  def create
    @family = Family.generate_new_including_user current_user

    render :show
  end

  def update
  end
end
