app.controller "TasksController", ($rootScope, $scope, Task)->
  $scope.tasks = {}

  $scope.hasTasks = ->
    return true if $scope.todolist.tasks.total_tasks_count > 0

  $scope.fetchTasks = ->
    if $scope.hasTasks()
      Task.query(
        task_list_id: $scope.todolist.id
        , (response) ->
          $scope.tasks = response
        , (error) ->
      )

app.directive 'todolist', ($rootScope) ->
  restrict: 'E'
  scope: {
    'todolist': '=tasklist'
  }
  replace: true
  controller: 'TasksController'
  template: '
    <div class="todolist">
      <h3>Title: {{todolist.title}}</h3>
      <p>Description : {{todolist.description}}</p>
      
      Created by {{username(todolist.user_id)}}
      Status: {{todolist.tasks.status}}

      <div ng-show="hasTasks()">
        <a ng-click="fetchTasks()">Show</a>
        <li ng-repeat="task in tasks">
          {{task.title}}
        </li>
      </div>
    </div>
  '

