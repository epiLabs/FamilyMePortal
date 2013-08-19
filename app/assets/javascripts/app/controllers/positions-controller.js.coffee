app.controller "PositionsController", ($scope, $location, $state, $stateParams, Position) ->

  $scope.fetchUsers()

  $scope.positions ||= {
    models: []
  }

  $scope.refreshMarkers = (param)=>
    return if param == @currentParam

    @currentParam = param
    callback = (response) ->
      $scope.positions.models = response
      $scope.$broadcast('refreshMarkers')

    if param == 'latest'
      Position.latest {}, callback
    else if param == 'all'
      Position.query {}, callback
    else
      console.log 'UNKNOWN PARAM ' + param

  if $state.current.name == 'positions.latest'
    $scope.refreshMarkers('latest')
  else
    $scope.refreshMarkers('all')

app.controller "MapController", ($scope, $location, $state) ->
  return unless google?

  unregister = $scope.$watch('myMap', (map)->
    $scope.$on('refreshMarkers', ->
      # Clear all markers
      if $scope.myMarkers
        for marker in $scope.myMarkers
          marker.setMap(null)

      # Set the markers
      $scope.myMarkers = []
      for position in $scope.positions.models
        $scope.myMarkers.push(new google.maps.Marker
          map: $scope.myMap,
          position: new google.maps.LatLng(position.latitude, position.longitude)
        )
    )

    $scope.$emit('refreshMarkers')
    unregister()
  )

  $scope.mapOptions ||= {
    center: new google.maps.LatLng(0, 0),
    zoom: 3,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  # TODO : try that
  # navigator.geolocation.getCurrentPosition((position)->
  #   $scope.myMap.panTo(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))
  # )

