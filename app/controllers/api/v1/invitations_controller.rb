class Api::V1::InvitationsController < ApiController
  before_filter :ensure_user_is_in_a_family, except: [:received, :accept, :reject]

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

  def accept
    invitation = Invitation.find(params[:id])
    
    if invitation.accept! current_user
      render json: {message: 'You just joined a family'}, status: 200
    else
      render json: {error: 'An error occured'}, status: 400
    end
  end

  def reject
    invitation = Invitation.find(params[:id])
    
    if invitation.reject! current_user
      render json: {message: 'Invitation successfully rejected'}, status: 200
    else
      render json: {error: 'An error occured'}, status: 400
    end
  end
end
