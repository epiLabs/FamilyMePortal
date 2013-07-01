app.controller "PostsController", ($scope, $http, $location, $state, $stateParams) ->

  # =========================================================================
  # Initialize
  # =========================================================================

  $scope.posts = {}

  if $state.current.name == 'posts'
    $http.get("/api/v1/posts"

    # success
    ).then ((response) ->
      $scope.posts = response.data
    # failure
    ), (error) ->
      console.log 'AN ERROR HAS OCCURED'

  $scope.post = {}
  if $state.current.name == 'edit'
    $http.get("/api/v1/posts/#{$stateParams['id']}"

    # success
    ).then ((response) ->
      $scope.post = response.data

    # failure
    ), (error) ->

  # =========================================================================
  # Create
  # =========================================================================

  $scope.create = ->
    $http.post("/api/v1/posts",
      post:
        message: $scope.post.message

    # success
    ).then ((response) ->
      $location.path "/posts"

    # failure
    ), (error) ->

  # =========================================================================
  # Update
  # =========================================================================

  $scope.update = ->
    $http.put("/api/v1/posts/#{$scope.post.id}",
      post:
        message: $scope.post.message

    # success
    ).then ((response) ->
      $location.path "/posts"

    # failure
    ), (error) ->

  # =========================================================================
  # Destroy
  # =========================================================================

  $scope.destroy = (id) ->
    if confirm 'Are you sure that you want to delete this post?'
      $http.delete("/api/v1/posts/#{id}"

      # success
      ).then ((response) ->
        $http.get("/api/v1/posts").then ((response) ->
          $scope.posts = response.data
        ), (error) ->

      # failure
      ), (error) ->

  return false
