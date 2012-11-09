class FamiliesController < ApplicationController
  before_filter :authenticate_user!, except: :show
  before_filter :go_to_family_homepage, except: [:show, :update, :edit], if: lambda {current_user.family.present?}

  def go_to_family_homepage
    redirect_to 'show'
  end

  def show
    unless user_signed_in?
      redirect_to controller: 'news', action: 'index'
      return
    end
    
    @family = current_user.family

    unless @family.present?
      redirect_to new_family_path, notice: "You should create a family first!"
    end
  end

  def create
    @family = Family.new(params[:family])

    if @family.save
      current_user.assign_family! @family
      redirect_to @family, notice: "Your family has been created successfuly!"
    else
      render 'new'
    end
  end

  def update
  end

  def edit
  end

  def new
    @family = Family.new
  end
end
