class Api::V1::InvitationsController < ApiController
  before_filter :ensure_user_is_authenticated
  before_filter :ensure_user_is_in_a_family, except: :received

  def index
    @invitations = current_user.family.invitations
  end

  def create
    @invitation = Invitation.new email: params[:email]
    @invitation.user = current_user
    @invitation.family = current_user.family

    if @invitation.save
      render json: @invitation, status: 200
    else
      render json: {error: @invitation.errors}, status: 400
    end
  end

  def received
    @invitations = current_user.invitations
  end
end
