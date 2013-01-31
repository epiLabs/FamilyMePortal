class FamilyMe.Models.Post extends Backbone.Model

  initialize: (model, options)->
    super model, options

    if @get 'user'
      @user = new FamilyMe.Models.User(@get 'user')

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