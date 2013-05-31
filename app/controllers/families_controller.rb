class FamiliesController < ApplicationController
  before_filter :ensure_user_is_authenticated, except: [:landing]

  def show
    if current_user.family
      redirect_to users_path
    end
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
        redirect_to users_path
      else
       render :show
     end
    else
      render 'layouts/landing', :layout => false
    end
  end
end
