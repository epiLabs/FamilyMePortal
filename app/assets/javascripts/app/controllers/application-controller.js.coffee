app.controller "ApplicationController", ($scope, $rootScope, $q, User) ->
  @user_id = $('#main-application').data('current-user-id')

  $scope.canEdit = (user_id)=>  
    @user_id == user_id
  $scope.canDelete = (user_id)=>    
    @user_id == user_id

  $scope.getUser = (user_id)=>
    for user in $rootScope.users
      if user.id == user_id
        return user

  $scope.username = (user_id)->
    $scope.getUser(user_id).display_name
  $scope.avatarUrl = (user_id)->
    $scope.getUser(user_id).avatar_url


  $scope.fetchUsers = =>
    unless $rootScope.users
      deferred = $q.defer()

      User.query(
        {}
        , (response) ->
          $rootScope.users = response
          deferred.resolve()

        , (error) ->
          alert "Couldn't fetch users"
      )

      return deferred.promise



