class FamilyMe.Models.User extends Backbone.Model

  initialize: (model, options)->
    super model, options

    console.log @
    console.log @get 'position'
