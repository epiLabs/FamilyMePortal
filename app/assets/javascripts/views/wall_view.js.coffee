class FamilyMe.Views.WallView extends Backbone.View
  template: JST['wall/index']
  el: '#posts'

  initialize: (options)->
    super options

  render: ->
    @$el.html(@template())

    @