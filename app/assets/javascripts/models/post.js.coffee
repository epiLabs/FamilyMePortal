class FamilyMe.Models.Post extends Backbone.Model

  initialize: (model, options)->
    super model, options

    if @get 'user'
      @user = new FamilyMe.Models.User(@get 'user')
