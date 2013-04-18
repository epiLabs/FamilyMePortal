class ApplicationController < ActionController::Base
  protect_from_forgery

  def ensure_user_is_authenticated
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to root_url, :alert => "You must be logged in to perform this action" }
        format.json { render :json => { :response => 'fail', :errors => "unauthorized" }, :status => :unauthorized}
      end
    end
  end

  def ensure_user_is_in_a_family
    unless current_user.family
      respond_to do |format|
        format.html { redirect_to root_path, :alert => "You are not in a family" }
        format.json { render :json => { :response => 'fail', :errors => "You are not part of a family" }, :status => :not_found}
      end
    end
  end
end
