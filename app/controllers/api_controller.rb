class ApiController < ApplicationController
  respond_to :json

  before_filter :ensure_user_is_authenticated
  before_filter :ensure_user_is_in_a_family
end
