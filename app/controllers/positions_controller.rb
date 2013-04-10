class PositionsController < ApplicationController
  before_filter :ensure_user_is_authenticated
  before_filter :ensure_user_is_in_a_family

  def index
  end
end
