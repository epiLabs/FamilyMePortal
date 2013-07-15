app.controller "TasksController", ($rootScope, $scope, Task)->
  $scope.tasks = {}
  $scope.newTaskTitle = ''
  $scope.isAddingNewTask = false
  $scope.users = $rootScope.getUsers()


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

  $scope.showNewTaskForm = ->
    $scope.isAddingNewTask = true

  $scope.create = ->
    Task.save(
      task_list_id: $scope.todolist.id
      ,
      task:
        title: $scope.newTaskTitle
        user_id: $scope.newTaskAssignedUserId
   
      , (response) ->
        $scope.tasks.push response

      , (errRes) ->
        $scope.error = errRes.data.error
    )

  $scope.username = $rootScope.username

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


      <button ng-hide="isAddingNewTask" ng-click="showNewTaskForm()">Create new task</button>
      <form ng-show="isAddingNewTask">
        <div ng-show="error">{{error}}</div>
        <input type="text" placeholder="Title" ng-model="newTaskTitle"
        required="true" ng-minlength="3" />
        <select ng-model="newTaskAssignedUserId" ng-options="o.id as o.display_name for o in users"></select>
        <button ng-click="create()">Submit</button>
      </form>
      <div ng-show="hasTasks()">
        <a ng-click="fetchTasks()">Show</a>
        <li ng-repeat="task in tasks">
          {{task.title}} ==> {{username(task.user_id)}} is assigned
        </li>
      </div>
    </div>
  '

