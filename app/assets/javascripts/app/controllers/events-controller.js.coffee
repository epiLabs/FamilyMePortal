app.controller 'EventsController', ($scope, $location, $state, $stateParams, Event) ->
  $scope.events = {}
  $scope.event = {}

  $scope.fetchUsers()

  $scope.refreshCalendar = ->

    eventsArray = []
    for ev in $scope.events
      eventsArray.push {title: ev.title, start: ev.start_date, end: ev.end_date, allDay: false, custom: ev}

    $('#calendar').fullCalendar
      header:
        left: 'prev,next today',
        center: 'title',
        right: 'month,basicWeek,basicDay'
      events: eventsArray
      eventAfterRender: (event, element)->
        description = event.custom.description || "<i>No description available</i>"
        $(element).popover(
          title: event.title
          placement: 'bottom'
          trigger: 'click'
          html: true
          content: "
            <div class='event-description'>#{description}</div>
            <div class='event-duration'>
              Duration: #{moment(event.start).from(moment(event.end), true)}
            </div>
            <div class='actions'>
              <a class='edit-event' href='events/#{event.custom.id}/edit'>Edit</a>
            </div>
          "
        )
  $scope.fetchEvents = ->
    Event.query(
      {}
      , (response) ->
        $scope.events = response
        $scope.refreshCalendar()
    )

  if $state.current.name == 'events.edit'
    Event.get(
      id: $stateParams['id']

      , (response) ->
        $scope.event = response
      , (error) ->
    )

  if $state.current.name == 'events'
    $scope.fetchEvents()

  $scope.create = ->
    Event.save(
      {},
      event:
        title: $scope.event.title
        description: $scope.event.description
        start_date: $scope.event.start_date
        end_date: $scope.event.end_date
   
      , (response) ->
        $location.path "/events"
      , (error)->
        $scope.error = error
    )
  $scope.update = ->
    Event.update
      id: $scope.event.id
    , event:
        title: $scope.event.title
        description: $scope.event.description
        start_date: $scope.event.start_date
        end_date: $scope.event.end_date
    , (reponse)->
      $location.path "/events"
    , (error)->
      console.log error
  $scope.destroy = (id) ->
    if confirm 'Are you sure that you want to delete this event?'
      Event.delete
        id: id
      , (response)->
        $scope.fetchEvents()
      , (error)->
        console.log error
