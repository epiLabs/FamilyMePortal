class FamilyMe.Views.InvitationsView extends Backbone.View
  template: JST['invitations/index']
  el: '#invitations-tab'
  events:
   'click .display-form-button' : 'showNewInvitationForm'

  initialize: (options)->
    super options

    @collection = new FamilyMe.Collections.Invitations()

    @collection.fetch
      success: =>
        @render()
      error: -> alert 'Error in InvitationsView'

  showNewInvitationForm: (event)->
    @$('.new-invitation').show()
    @$('.display-form-button').hide()
    
  hideNewInvitationForm: (event)->
    @$('.new-invitation').hide()
    @$('.display-form-button').show()

  render: ->
    @$el.html(@template())
    @hideNewInvitationForm()

    for model in @collection.models
      @$('.invitations-list').append JST['invitations/show'](model: model)

    @
