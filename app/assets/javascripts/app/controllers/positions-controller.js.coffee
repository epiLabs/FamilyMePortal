app.controller "PositionsController", ($scope, $location, $state, $stateParams, Position) ->

  $scope.positions = {}

  $scope.fetchUsers()

app.controller "MapController", ($scope, $location, $state, $stateParams, Position) ->

  return unless google?

  $scope.fetchMarkers = ->
    Position.query(
      {}
      , (response) ->
        $scope.myMarkers = []
        for position in response
          $scope.myMarkers.push(new google.maps.Marker
            map: $scope.myMap,
            position: new google.maps.LatLng(position.latitude, position.longitude)
          )
    )

  unregister = $scope.$watch('myMap', (map)->
    if (map)
      $scope.fetchMarkers()
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

