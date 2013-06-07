class FamilyMe.Views.EventsView extends Backbone.View
  template: JST['events/index']
  el: '#display-events'
  events:
    'click .modal-footer .btn-success' : 'createEvent'

  createEvent: (event)->
    console.log 'DO STUFF'

  initialize: (options)->
    super options

    @collection = new FamilyMe.Collections.Events()

    # Keep this line to build the eventViews array before binding the collection
    @eventViews()

    @collection.bind 'add', (model)=>
      eventView = new FamilyMe.Views.EventView(model: model)
      @registereventView(eventView)
      @eventViews().push(eventView)

      @$('.events-list').prepend eventView.render().el

    @collection.fetch update: true

  removePost: (post)=>
    eventView = null
    @_eventViews = _.reject @_eventViews, (item)->
      if item.model == post
        eventView = item
    eventView.remove()
    @render()

  registereventView: (eventView)->
    eventView.model.bind "destroy", @removePost
  eventViews:->
    unless @_eventViews
      @_eventViews = _.map @collection.models, (post)=>
        eventView = new FamilyMe.Views.EventView(model: post)
        @registereventView(eventView)
        eventView

    @_eventViews

  render: ->
    @$el.html(@template())

    for view in @eventViews()
      @$('.events-list').prepend view.render().el
    @
