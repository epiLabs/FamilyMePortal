class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource

    if resource.save
      set_flash_message :notice, :signed_up if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource) do |format|
        format.html
        format.json do
          render :json => { :response => 'ok', :id => resource.id, :auth_token => resource.authentication_token }.to_json, :status => :ok
        end
      end
    else
      clean_up_passwords resource
      respond_with resource do |format|
        format.html
        format.json do
          render json: {error: resource.errors}
        end
      end
    end
  end
end
