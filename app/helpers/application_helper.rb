module ApplicationHelper

  def current_user_avatar
    current_user.gravatar_url(size: 20)
  end
end
