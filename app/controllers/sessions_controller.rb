class SessionsController < Devise::SessionsController
  def create
    @resource = warden.authenticate!(:scope => resource_name, :recall => "sessions#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, @resource)

    respond_to do |format|
      format.html do
        respond_with @resource, :location => after_sign_in_path_for(@resource)
      end
      format.json do
        # Do something here to log that we are on loggin from mobile app
        render json: {:response => 'ok',
                      :nickname => current_user.nickname,
                      :first_name => current_user.first_name, 
                      :last_name => current_user.last_name,
                      :auth_token => current_user.authentication_token
                    }.to_json, :status => :ok
      end
    end
  end

end
