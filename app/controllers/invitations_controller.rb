class InvitationsController < ApplicationController
  before_filter :ensure_user_is_authenticated
  before_filter :ensure_user_is_in_a_family, except: [:accept, :reject]
  before_filter :detect_locale

  def index
    @invitations = current_user.family.invitations
  end

  def accept
    invitation = Invitation.find(params[:id])

    if invitation.accept! current_user
      redirect_to root_path, notice: "You are now in a family!"
    else
      redirect_to root_path, error: "An error has occured"
    end
  end

  def reject
    invitation = Invitation.find(params[:id])

    if invitation.reject! current_user
      flash[:notice] = "You have rejected an invitation"
    else
      flash[:error] = "An error occured"
    end

    redirect_to root_path
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new params[:invitation]
    @invitation.user = current_user
    @invitation.family = current_user.family

    if @invitation.save
      redirect_to action: :index, notice: "Invitation successfully sent!"
    else
      render :new
    end
  end
end
