class FamilyMe.Views.ApplicationView extends Backbone.View

  initialize: (options)->
    super options

    @WallView()
    @EventsView()

  WallView:->
    @_wallView ||= new FamilyMe.Views.WallView()
  EventsView:->
    @_eventsView ||= new FamilyMe.Views.EventsView()
  PositionsView:->
    @_positionsView ||= new FamilyMe.Views.PositionsView()

  render: ->
    @WallView().render()
    @EventsView().render()
    @PositionsView().render()

    @
