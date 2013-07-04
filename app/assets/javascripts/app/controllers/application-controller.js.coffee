app.controller "ApplicationController", ($scope) ->

  $scope.canEdit = (user_id)->    
    $('#main-application').data('current-user-id') == user_id
  $scope.canDelete = (user_id)->    
    $('#main-application').data('current-user-id') == user_id
