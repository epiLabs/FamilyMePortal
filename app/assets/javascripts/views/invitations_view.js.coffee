class FamilyMe.Views.InvitationsView extends Backbone.View
  template: JST['invitations/index']
  el: '#invitations-tab'
  events:
   'click .display-form-button' : 'showNewInvitationForm'

  showNewInvitationForm: (event)->
    @$('.new-invitation').show()
    @$('.display-form-button').hide()
    
  hideNewInvitationForm: (event)->
    @$('.new-invitation').hide()
    @$('.display-form-button').show()


  render: ->
    @$el.html(@template())
    @hideNewInvitationForm()

    # for view in @postViews()
    #   @$('.posts-list').prepend view.render().el
    @
