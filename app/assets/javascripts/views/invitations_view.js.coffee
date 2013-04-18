class FamilyMe.Views.InvitationsView extends Backbone.View
  template: JST['invitations/index']
  el: '#invitations-tab'
  events:
    'submit .new-invitation form' : 'submitNewInvitation'
    'click .display-form-button' : 'showNewInvitationForm'

  initialize: (options)->
    super options

    @fetchCollection()

  fetchCollection:->
    @collection ||= new FamilyMe.Collections.Invitations()

    @collection.fetch
      success: =>
        @render()
      error: -> alert 'Error in InvitationsView'

  submitNewInvitation: (event)->
    email = @$('.new-invitation input').val()

    $('.alert-error').text('')
    $('.alert-success').text('')
    if email.length
      $.ajax
        url: @collection.url
        type: 'POST'
        dataType: 'json'
        data: "email=#{email}"
        error: (xhr, text, error) =>
          $('.alert-error').text $.parseJSON(xhr.responseText)['error']['email']
        success: (data, text, xhr) =>
          @text = "Invitation sent!"
          @fetchCollection()
          @$('.new-post input').val('')
    false

  showNewInvitationForm: (event)->
    @$('.new-invitation').show()
    @$('.display-form-button').hide()
    
  hideNewInvitationForm: (event)->
    @$('.new-invitation').hide()
    @$('.display-form-button').show()

  render: ->
    @$el.html(@template())
    @hideNewInvitationForm()

    if @text?
      $('.alert-success').text @text
      @text = null

    for model in @collection.models
      @$('.invitations-list').append JST['invitations/show'](model: model)

    @
