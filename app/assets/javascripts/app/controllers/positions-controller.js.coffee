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
      $scope.myMarkers = []

      bounds = new google.maps.LatLngBounds();
      infowindow = new google.maps.InfoWindow content: 'Waiting...'

      # Set the markers
      for position in $scope.positions.models
        marker = new google.maps.Marker
          map: $scope.myMap,
          position: new google.maps.LatLng position.latitude, position.longitude
          title: "#{$scope.username(position.user_id)} on #{position.created_at}"
          icon: $scope.avatarUrl(position.user_id)
          custom: position

        $scope.myMarkers.push marker
        bounds.extend(marker.position)

      for marker in $scope.myMarkers
        google.maps.event.addListener marker, 'click', ->
          infowindow.setContent "<p>#{$scope.username(@custom.user_id)}</p>
          Position checked out the #{@custom.created_at}"
          infowindow.open($scope.myMap, @ )

      # Auto-center the map
      map.fitBounds(bounds)
    )

    $scope.$emit('refreshMarkers')
    unregister()
  )

  $scope.mapOptions ||= {
    center: new google.maps.LatLng(0, 0),
    zoom: 4,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  # TODO : try that
  # navigator.geolocation.getCurrentPosition((position)->
  #   $scope.myMap.panTo(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))
  # )

