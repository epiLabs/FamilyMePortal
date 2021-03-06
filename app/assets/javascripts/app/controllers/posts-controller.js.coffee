app.controller "PostsController", ($scope, $location, $state, $stateParams, Post) ->

  # =========================================================================
  # Initialize
  # =========================================================================
  $scope.posts = {}
  $scope.post = {}

  $scope.fetchUsers()

  if $state.current.name == 'posts'
    Post.query(
      {}
      , (response) ->
        $scope.posts = response
      , (error) ->
    )

  if $state.current.name == 'posts.edit'
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
