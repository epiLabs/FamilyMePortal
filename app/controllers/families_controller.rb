class FamiliesController < ApplicationController
  before_filter :ensure_user_is_authenticated, except: [:landing]

  def show
    @family = current_user.family

    unless @family
      redirect_to action: :new, notice: "You need to be in a family to access this feature"
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
       redirect_to action: :show
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
