class FamilyMe.Models.Position extends Backbone.Model

  initialize: (model, options)->
    super model, options

  getLatitude: ->
    @get 'latitude'

  getLongitude: ->
    @get 'longitude'

  getTitle: ->
    "Default Title"