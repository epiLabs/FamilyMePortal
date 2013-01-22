class FamilyMe.Collections.Positions extends Backbone.Collection
  model: FamilyMe.Models.Position
  url: '/positions'

  initialize: (options)->
    super options