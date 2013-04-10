class FamilyMe.Models.Post extends Backbone.Model

  initialize: (model, options)->
    super model, options

    @user = FamilyMe.UsersList.get(@get 'user_id')

  canBeDeleted:->
    if @user
      @user.isCurrentUser()

  getAuthor:->
    if @user
      if @user.isCurrentUser()
        'You'
      else
        @user.getTitle()
    else
      'No author'

  getMessage:->
    @get 'message'
