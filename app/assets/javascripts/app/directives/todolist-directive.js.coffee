app.controller "TodolistDetailController", ($rootScope, $scope, $state, $stateParams, Task, Todo) ->
  $scope.fetchUsers()
  $scope.task_list = {}
  $scope.tasks = []

  $scope.getPanelClass = (status)->
    count = completed = 0

    for task in $scope.tasks
      if task.finished
        completed++
      count++

    if count
      if count == completed then 'panel-success' else 'panel-info'
    else
      'panel-warning'

  $scope.resetValues = ->
    $scope.newTaskTitle = ''
    $scope.newTaskAssignedUserId = null
    $scope.isAddingNewTask = false

  $rootScope.refresh = ->
    Todo.get(
      id: $stateParams['id']
      , (response) ->
        $scope.task_list = response
        $scope.fetchTasks()
    )

  $scope.hasTasks = ->
    return true if $scope.task_list.tasks && $scope.task_list.tasks.total_tasks_count > 0

  $scope.fetchTasks = ->
    if $scope.hasTasks()
      Task.query(
        task_list_id: $scope.task_list.id
        , (response) ->
          $scope.tasks = response
      )

  $scope.showNewTaskForm = ->
    $scope.newTaskTitle = ''
    $scope.newTaskAssignedUserId = null
    $scope.isAddingNewTask = true

  $scope.create = ->
    Task.save(
      task_list_id: $scope.task_list.id
      ,
      task:
        title: $scope.newTaskTitle
        user_id: $scope.newTaskAssignedUserId
   
      , (response) ->
        $scope.tasks.push response
        $scope.resetValues()
        $scope.refresh()

      , (errRes) ->
        $scope.error = errRes.data.error
    )

  $scope.resetValues()
  $scope.refresh()


app.controller "TaskController", ($rootScope, $scope, Task, Todo, $stateParams)->
  $scope.users = $rootScope.getUsers()
  $scope.username = $rootScope.username

  $scope.editMode = ->
    $scope.isEditing = true
    $scope.originalTitle = $scope.task.title
    $scope.originalUserID = $scope.task.user_id

  $scope.update = ->
    $scope.error = ''
    Task.update(
      task_list_id: $stateParams['id']
      id: $scope.task.id
      ,
      task:
        title: $scope.task.title || ''
        user_id: $scope.task.user_id
   
      , (response) ->
        $scope.task = response
        $scope.isEditing = false

      , (errRes) ->
        $scope.error = errRes.data.error
    )

  $scope.cancelEditing = ->
    $scope.task.title = $scope.originalTitle
    $scope.task.user_id = $scope.originalUserID
    $scope.isEditing = false

  $scope.toggleStatus = ->
    Task.finish(
      task_list_id: $stateParams['id']
      id: $scope.task.id
      ,
      cancel: !$scope.task.finished

      , (response) ->
        $scope.task.finished = response.finished
        $rootScope.refresh()
      , (errRes) ->
        alert 'something strange happened'
    )

  $scope.destroy = (id) ->
    if confirm 'Are you sure that you want to delete this task?'
      Task.delete(
        task_list_id: $stateParams['id']
        id: $scope.task.id
      , (response)->
        $rootScope.refresh()
      )


app.directive 'todo', ($rootScope) ->
  restrict: 'E'
  scope: {
    'task': '='
  }
  replace: true
  controller: 'TaskController'
  template: '
    <div class="task">
      <form ng-show="isEditing">
        <div ng-show="error">{{error}}</div>
        <input type="text" placeholder="Title" ng-model="task.title" required="true" />
        <select ng-model="task.user_id" ng-options="o.id as o.display_name for o in users"></select>
        <button ng-click="update()">Submit</button>
        <button ng-click="cancelEditing()">Cancel</button>
      </form>
      <div ng-hide="isEditing" class="row">
        <div class="col-md-1 col-md-offset-1 toggle-task-status">
          <input type="checkbox" ng-change="toggleStatus()" ng-model="task.finished" />
        </div>

        <div class="col-md-6" ng-class="task.finished ? \'finished-task\' : \'\'">
          {{task.title}}
        </div>
        <div class="col-md-2" class="assigned_user">
          <div ng-if="task.user_id">
            {{username(task.user_id)}}
          </div>
        </div>

        <div class="col-md-1 actions">
          <a class="edit-task glyphicon glyphicon-edit" href="" ng-click="editMode()" title="Edit"></a>
          <a class="delete-task glyphicon glyphicon-remove" href="" ng-click="destroy()" title="Delete"></a>
        </div>
      </div>
    </div>
  '