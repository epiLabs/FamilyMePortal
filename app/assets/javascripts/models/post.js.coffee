class FamilyMe.Models.Post extends Backbone.Model

  initialize: (model, options)->
    super model, options

    @user = FamilyMe.UsersList.get(@get 'user_id')

  canBeDeleted:->
    if @user
      @user.isCurrentUser()

  getAuthor:->
    if @user
      @user.getTitle()
    else
      'Unknown'

  getAuthorAvatarUrl:->
    if @user
      @user.getAvatarUrl()

  getMessage:->
    @get 'message'
