class FamilyMe.Views.PostView extends Backbone.View
  template: JST['post/show']

  render: ->
    @$el.html(@template(model: @model))

    @