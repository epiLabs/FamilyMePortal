class Api::V1::InvitationsController < ApiController
  before_filter :ensure_user_is_authenticated
  before_filter :ensure_user_is_in_a_family, except: :received

  def index
  end

  def create
  end

  def received

  end
end
