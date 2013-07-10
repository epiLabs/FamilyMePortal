app.controller "PostsController", ($rootScope, $scope, $http, $location, $state, $stateParams, Post) ->

  # =========================================================================
  # Initialize
  # =========================================================================
  $scope.posts = {}
  $scope.post = {}

  if $state.current.name == 'posts'
    $scope.fetchUsers()

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
   
      , (response) ->
        $location.path "/posts"
      , (error) ->
    )

  # =========================================================================
  # Update
  # =========================================================================
  $scope.update = ->
    Post.update
      id: $scope.post.id
    , post:
        message: $scope.post.message
    , (reponse)->
      $location.path "/posts"
    , (error)->
      console.log error

  # =========================================================================
  # Destroy
  # =========================================================================
  $scope.destroy = (id) ->
    if confirm 'Are you sure that you want to delete this post?'
      Post.delete
        id: id
      , (response)->
        $scope.posts = Post.query()
      , (error)->
        console.log error
