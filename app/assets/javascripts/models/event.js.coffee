class FamilyMe.Models.Event extends Backbone.Model

  initialize: (model, options)->
    super model, options

    @user = FamilyMe.UsersList.get(@get 'user_id')

  getAuthor:->
    @user.getTitle()

  getAuthorAvatarUrl:->
    @user.getAvatarUrl()

  getTitle:->
    @get 'title'
  getStartDate:->
    @get 'start_date'
  getEndDate:->
    @get 'end_date'
