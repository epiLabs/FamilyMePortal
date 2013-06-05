class FamiliesController < ApplicationController
  before_filter :ensure_user_is_authenticated, except: [:landing]

  def show
    redirect_to action: :new unless current_user.family
  end

  def create
    @family = Family.generate_new_including_user current_user

    redirect_to action: :show
  end

  def update
  end

  def landing
    if current_user
      if current_user.family
       render :show
      else
       render :new
     end
    else
      render 'layouts/landing', :layout => false
    end
  end

  def new
  end
end
