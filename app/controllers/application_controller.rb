class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
    dashboard_path
  end

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

  def detect_locale
    if params[:locale].present?
      I18n.locale = params[:locale]
    elsif
      if request.method == "GET"
        new_locale = http_accept_language.compatible_language_from(I18n.available_locales)
        new_locale = I18n.default_locale.to_s unless new_locale

        redirect_to url_for(locale: new_locale) unless params[:disable_redirect]
      end
    end
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end
end
