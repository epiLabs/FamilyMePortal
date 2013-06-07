class FamilyMe.Views.EventView extends Backbone.View
  template: JST['events/show']

  render: ->
    @$el.html(@template(model: @model))
    @
