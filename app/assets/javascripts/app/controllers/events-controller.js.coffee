app.controller 'EventsController', ($scope, $location, $state, $stateParams, Event) ->
  $scope.events = {}
  $scope.event = {}

  $scope.fetchUsers()


  $scope.refreshCalendar = ->

    eventsArray = []
    for ev in $scope.events
      eventsArray.push {title: ev.title, start: ev.start_date, end: ev.end_date}

    console.log eventsArray
    $('#calendar').fullCalendar(
      header:
        left: 'prev,next today',
        center: 'title',
        right: 'month,basicWeek,basicDay'
      events: eventsArray
    )

  $scope.fetchEvents = ->
    Event.query(
      {}
      , (response) ->
        $scope.events = response
        $scope.refreshCalendar()
    )


  $scope.fetchEvents()