app.controller "PostsController", ($scope, $http, $location, $state, $stateParams, Post) ->

  # =========================================================================
  # Initialize
  # =========================================================================
  $scope.posts = {}
  $scope.post = {}

  if $state.current.name == 'posts'
    Post.query(
      {}
      , (response) ->
        $scope.posts = response
      , (error) ->
    )

  if $state.current.name == 'edit'
    Post.get(
      id: $stateParams['id']

      , (response) ->
        $scope.post = response
      , (error) ->
    )

  # =========================================================================
  # Create
  # =========================================================================
  $scope.create = ->
    Post.save(
      {},
      post:
        message: $scope.post.message
   
        # Success
      , (response) ->
        $location.path "/posts"
   
        # Error
      , (response) ->
    )

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
