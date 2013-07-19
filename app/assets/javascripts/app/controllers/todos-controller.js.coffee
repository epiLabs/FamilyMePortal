app.controller "TodosController", ($scope, $location, $state, $stateParams, $log, Todo) ->
  $scope.task_lists = {}
  $scope.task_list = {}

  $scope.search = {tasks: {status: 'all'}}

  $scope.fetchUsers()

  if $state.current.name == 'todos'
    Todo.query(
      {}
      , (response) ->
        $scope.task_lists = response
      , (error) ->
        $log.error error
    )

  if $state.current.name == 'todos.edit'
    Todo.get(
      id: $stateParams['id']

      , (response) ->
        $scope.task_list = response
      , (error) ->
    )

    # =========================================================================
  # Create
  # =========================================================================
  $scope.create = ->
    $scope.task_list.title = $scope.task_list.title.trim()
    Todo.save(
      {},
      task_list:
        title: $scope.task_list.title
        description: $scope.task_list.description
   
      , (response) ->
        $location.path "/todos"
      , (error) ->
    )

  # =========================================================================
  # Update
  # =========================================================================
  $scope.update = ->
    Todo.update
      id: $scope.task_list.id
    , task_list:
        title: $scope.task_list.title
        description: $scope.task_list.description
    , (reponse)->
      $location.path "/todos"
    , (error)->
      console.log error

  # =========================================================================
  # Destroy
  # =========================================================================
  $scope.destroy = (id) ->
    if confirm 'Are you sure that you want to delete this Todo?'
      Todo.delete
        id: id
      , (response)->
        $scope.task_lists = Todo.query()
      , (error)->
        console.log error
