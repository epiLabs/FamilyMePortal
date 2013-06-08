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
  TaskListsView:->
    @_taskListsView ||= new FamilyMe.Views.TaskListsView()

  render: ->
    @WallView().render()
    @EventsView().render()
    @PositionsView().render()
    @TaskListsView().render()

    @
