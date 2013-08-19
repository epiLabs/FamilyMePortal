app.controller "ApplicationController", ($scope, $rootScope, $q, User) ->
  $rootScope.currentUserId = @user_id = parseInt($('#main-application').data('current-user-id'))

  $rootScope.canEdit = (user_id)=>  
    @user_id == user_id
  $rootScope.canDelete = (user_id)=>    
    @user_id == user_id

  $rootScope.getUser = (user_id)=>
    for user in $rootScope.users
      if user.id == user_id
        return user

  $rootScope.username = (user_id)->
    return unless user_id?
    
    user = $rootScope.getUser(user_id)

    return user.display_name if user

  $rootScope.avatarUrl = (user_id)->
    $rootScope.getUser(user_id).avatar_url
  $rootScope.getUsers = ()->
    $rootScope.users


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



