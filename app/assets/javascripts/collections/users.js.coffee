class FamilyMe.Collections.Users extends Backbone.Collection
  model: FamilyMe.Models.User
  url: '/users'

  initialize: (options)->
    super options
