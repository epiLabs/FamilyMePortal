class FamilyMe.Models.Invitation extends Backbone.Model

  initialize: (model, options)->
    super model, options

    @user = FamilyMe.UsersList.get(@get('inviter').id)

  getAuthor:->
    @user.getTitle()
  getEmail:->
    @get 'email'
  getStatus:->
    @get 'status'

  getRowClass:->
    status = @get 'status'

    switch status
      when 'pending' then 'warning'
      when 'declined' then 'error'
      when 'accepted' then 'success'
