class FamilyMe.Collections.Users extends Backbone.Collection
  model: FamilyMe.Models.User
  url: '/api/v1/users'

  initialize: (options)->
    super options
