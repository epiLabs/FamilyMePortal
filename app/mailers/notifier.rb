class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def send_invitation(invitation)
    @email = invitation.email
    @user = invitation.user
    mail :to => @email
  end
end
