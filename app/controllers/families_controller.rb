require 'icalendar'

class FamiliesController < ApplicationController
  include Icalendar
  before_filter :ensure_user_is_authenticated, except: [:landing]

  def show
    @family = current_user.family

    unless @family
      redirect_to action: :new, notice: "You need to be in a family to access this feature"
    end
  end

  def create
    @family = Family.generate_new_including_user current_user

    redirect_to dashboard_path
  end

  def update
  end

  def landing
    if current_user
      if current_user.family
       render :show
      else
       render :new
     end
    else
      render 'layouts/landing', :layout => false
    end
  end

  def new
  end

  def icalendar
    events = current_user.family.events

    if params[:ical_token] != current_user.get_ical_token
      redirect_to root_path, alert: "You are not allowed to do this"
      return
    end

    cal = Calendar.new

    events.each do |event|
      cal.add_event(event.to_ics)
    end

    cal.publish
    render text: cal.to_ical, layout: false
  end
end
