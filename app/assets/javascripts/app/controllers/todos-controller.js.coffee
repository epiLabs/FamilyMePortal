app.controller "TodosController", ($scope, $location, $state, $stateParams, $log, Todo) ->
  $scope.todolists = {}
  $scope.todolist = {} # Contains tasks

  $scope.search = {tasks: {status: 'all'}}

  $scope.fetchUsers()

  if $state.current.name == 'todos'
    Todo.query(
      {}
      , (response) ->
        $scope.todolists = response
      , (error) ->
        $log.error error
    )

