app.controller "PositionsController", ($scope, $location, $state, $stateParams, Position) ->

  $scope.fetchUsers()

  $scope.selectedUser = $scope.currentUserId
  $scope.selectedUser = parseInt($location.search().user_id) if $location.search().user_id

  $scope.positions = models: []

  $scope.selectUser = (param)->
    $location.search(user_id: param)
    $scope.refreshMarkers(param)

  $scope.refreshMarkers = (param)=>
    return if param == @currentParam

    @currentParam = param
    callback = (response) ->
      $scope.positions.models = response
      $scope.$broadcast('refreshMarkers')

    if param == 'latest'
      Position.latest {}, callback
      $scope.filter = false
    else
      Position.query {user_id: $scope.selectedUser}, callback
      $scope.filter = true

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
          infowindow.setContent "<p>#{$scope.username(@custom.user_id)}</p><i>Position checked out the #{@custom.created_at}<i>"
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

