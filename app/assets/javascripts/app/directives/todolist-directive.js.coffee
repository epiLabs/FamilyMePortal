app.controller "TodolistDetailController", ($rootScope, $scope, $state, $stateParams, Task, Todo) ->
  $scope.fetchUsers()
  $scope.task_list = {}
  $scope.tasks = []
  $scope.task = {}

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

  $scope.refresh = ->
    Todo.get(
      id: $stateParams['id']
      , (response) ->
        $('#myModal').modal('hide')
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

  $scope.resetTaskForm = ->
    $scope.task = {}
    $scope.error = ''

  $scope.saveTask = ->
    $scope.error = ''

    if $scope.task.title
      $scope.task.title = $scope.task.title.trim()

    params = {task: {title: $scope.task.title, user_id: $scope.task.user_id}}
    success_callback = (response) ->
      $scope.refresh()
    failure_callback = (errRes) -> $scope.error = errRes.data.error

    if $scope.task.id
      Task.update {task_list_id: $scope.task_list.id, id: $scope.task.id}, params, success_callback, failure_callback
    else
      Task.save {task_list_id: $scope.task_list.id}, params, success_callback, failure_callback

  $scope.refresh()

  $scope.$on('editTask', (event, task)->
    $scope.error = ''
    $scope.task = task
  )
  $scope.$on('toggleTaskStatus', (event, task)->
    Task.finish(
      task_list_id: $stateParams['id']
      id: task.id
      ,
      cancel: !task.finished
      , (response) -> $scope.refresh()
    )
  )
  $scope.$on('destroyTask', (event, id)->
    Task.delete(
      task_list_id: $stateParams['id']
      id: id
    , (response)-> $scope.refresh()
    )
  )

app.controller "TaskController", ($rootScope, $scope)->
  $scope.users = $rootScope.getUsers()
  $scope.username = $rootScope.username

  $scope.editMode = (task)->
    $scope.$emit('editTask', task)

  $scope.toggleStatus = (task)->
    $scope.$emit('toggleTaskStatus', task)

  $scope.destroy = (id) ->
    if confirm 'Are you sure that you want to delete this task?'
      $scope.$emit('destroyTask', id)

app.directive 'todo', ($rootScope) ->
  restrict: 'E'
  scope: {
    'task': '='
  }
  replace: true
  controller: 'TaskController'
  template: '
    <div class="task">
      <div class="row">
        <div class="col-md-1 col-md-offset-1 toggle-task-status">
          <input type="checkbox" ng-change="toggleStatus(task)" ng-model="task.finished" />
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
          <a class="edit-task glyphicon glyphicon-edit" href="" ng-click="editMode(task)" data-toggle="modal" data-target="#myModal" title="Edit"></a>
          <a class="delete-task glyphicon glyphicon-remove" href="" ng-click="destroy(task.id)" title="Delete"></a>
        </div>
      </div>
    </div>
  '