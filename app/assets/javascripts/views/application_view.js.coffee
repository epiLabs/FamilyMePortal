class FamilyMe.Views.ApplicationView extends Backbone.View

  initialize: (options)->
    super options

    @wallView()

  wallView:->
    @_wallView ||= new FamilyMe.Views.WallView()

  render: ->
    @wallView().render()

    @
