app.controller "PositionsController", ($scope, $location, $state, $stateParams, Position) ->

  $scope.fetchUsers()

  $scope.selectedUser = $scope.currentUserId
  $scope.selectedUser = parseInt($location.search().user_id) if $location.search().user_id
  $scope.currentUserPosition = null
  $scope.boundToUserPosition = false

  $scope.positions = models: []

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position)->
      Position.save(
        {}
      ,
        position:
          latitude: position.coords.latitude
          longitude: position.coords.longitude
      , (response) ->
        $scope.currentUserPosition = response
        $scope.boundToUserPosition = true
        $scope.refreshMarkers(@currentParam, true)
      )

  $scope.selectUser = (param)->
    $location.search(user_id: param)
    $scope.refreshMarkers(param)

  $scope.refreshMarkers = (param, bypass = false)=>

    if param == @currentParam && !bypass
      return 

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

  # Call the marker refresh on end of page load
  if $state.current.name == 'positions.latest'
    $scope.refreshMarkers('latest')
  else
    $scope.refreshMarkers('all')

app.controller "MapController", ($scope, $location, $state) ->

  $scope.fitBounds = (elements, isArray = true)->
    bounds = new google.maps.LatLngBounds()

    if isArray
      for element in elements
        bounds.extend(element.position)
    else
      bounds.extend(new google.maps.LatLng(elements.latitude, elements.longitude))

    $scope.myMap.fitBounds(bounds)

  $scope.setInfoWindows = (elements)=>
    infowindow = new google.maps.InfoWindow content: 'Waiting...'

    for marker in elements
      google.maps.event.addListener marker, 'click', ->
        infowindow.setContent "
          <img src='#{$scope.avatarUrl(@custom.user_id)}' class='avatar'/>
          <p>#{$scope.username(@custom.user_id)}</p>
          <i>
            #{moment(@custom.updated_at, "YYYY-MM-DDTHH:mm:ssZ").fromNow()}
          <i>
        "
        infowindow.open($scope.myMap, @ )


  $scope.refreshMarkersOnMap = =>
      # Clear all markers
      if $scope.myMarkers
        for marker in $scope.myMarkers
          marker.setMap(null)
      $scope.myMarkers = []

      # Set the markers
      for position in $scope.positions.models
        marker = new google.maps.Marker
          map: $scope.myMap
          position: new google.maps.LatLng position.latitude, position.longitude
          title: $scope.username(position.user_id)
          custom: position

        $scope.myMarkers.push marker

        # Make the current location bounce
        if $scope.currentUserPosition && position.id == $scope.currentUserPosition.id
          marker.setAnimation(google.maps.Animation.BOUNCE)

      # Set infowindows
      $scope.setInfoWindows($scope.myMarkers)

      # Auto-center the map - 1) To the current user position, 2) To contain all the markers
      if $scope.boundToUserPosition
        $scope.fitBounds($scope.currentUserPosition, false)
        $scope.boundToUserPosition = false
      else
        $scope.fitBounds($scope.myMarkers)

  $scope.$watch('myMap', (map)->
    $scope.$on('refreshMarkers', $scope.refreshMarkersOnMap)
    $scope.$emit('refreshMarkers')
  )

  $scope.mapOptions =
    center: new google.maps.LatLng(0, 0)
    zoom: 4
    mapTypeId: google.maps.MapTypeId.ROADMAP
