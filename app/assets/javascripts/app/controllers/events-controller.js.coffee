app.controller 'EventsController', ($scope, $location, $state, $stateParams, Event) ->
  $scope.events = {}
  $scope.event = {}

  $scope.fetchUsers()

  $scope.refreshCalendar = ->

    eventsArray = []
    for ev in $scope.events
      eventsArray.push {title: ev.title, start: ev.start_date, end: ev.end_date, description: ev.description, custom: ev}

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
              <a class='edit-event'>Edit</a>
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

  $scope.fetchEvents()