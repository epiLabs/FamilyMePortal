app.controller "PositionsController", ($scope, $location, $state, $stateParams, Position) ->

  $scope.positions = {}

  # $scope.fetchUsers()


app.controller "MapController", ($scope, $location, $state, $stateParams, Position) ->
  if google
    $scope.mapOptions = {
      center: new google.maps.LatLng(35.784, -78.670),
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
