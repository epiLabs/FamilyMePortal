app.controller 'EventsController', ($scope, $location, $state, $stateParams, Event) ->
  $scope.events = {}
  $scope.event = {}

  $scope.fetchUsers()


  $scope.refreshCalendar = ->

    eventsArray = []
    for ev in $scope.events
      eventsArray.push {title: ev.title, start: ev.start_date, end: ev.end_date, custom: ev}

    $('#calendar').fullCalendar
      header:
        left: 'prev,next today',
        center: 'title',
        right: 'month,basicWeek,basicDay'
      events: eventsArray
      eventClick: (element, event)->
        $scope.$apply ->
          $scope.event = element.custom

  $scope.fetchEvents = ->
    Event.query(
      {}
      , (response) ->
        $scope.events = response
        $scope.refreshCalendar()
    )


  $scope.fetchEvents()