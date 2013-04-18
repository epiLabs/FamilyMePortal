class InvitationsController < ApplicationController
  before_filter :ensure_user_is_authenticated

  def new
  end

  def accept
    invitation = Invitation.find(params[:id])
    
    if invitation.accept! current_user
      redirect_to family_path, notice: "You are now in a family!"
    else
      redirect_to root_path, error: "An error has happened"
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
end
