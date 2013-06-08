class FamilyMe.Views.EventView extends Backbone.View
  template: JST['events/show']
  tagName: 'tr'

  render: ->
    @$el.html(@template(model: @model))
    @
