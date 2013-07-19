app.controller "TasklistsController", ($rootScope, $scope, Task, Todo)->
  $scope.tasks = []
  $scope.isAddingNewTask = false
  $scope.users = $rootScope.getUsers()
  $scope.username = $rootScope.username

  $rootScope.refresh = ->
    Todo.get(
      id: $scope.tasklist.id
      , (response) ->
        $scope.tasklist = response
        $scope.fetchTasks()
    )

  $scope.hasTasks = ->
    return true if $scope.tasklist.tasks.total_tasks_count > 0

  $scope.fetchTasks = ->
    if $scope.hasTasks()
      Task.query(
        task_list_id: $scope.tasklist.id
        , (response) ->
          $scope.tasks = response
        , (error) ->
      )

  $scope.showNewTaskForm = ->
    $scope.newTaskTitle = ''
    $scope.newTaskAssignedUserId = null
    $scope.isAddingNewTask = true

  $scope.create = ->
    Task.save(
      task_list_id: $scope.tasklist.id
      ,
      task:
        title: $scope.newTaskTitle
        user_id: $scope.newTaskAssignedUserId
   
      , (response) ->
        $scope.tasks.push response
        $scope.newTaskTitle = ''
        $scope.newTaskAssignedUserId = null
        $scope.isAddingNewTask = false

      , (errRes) ->
        $scope.error = errRes.data.error
    )

app.directive 'todolist', ($rootScope) ->
  restrict: 'E'
  scope: {
    'tasklist': '='
  }
  replace: true
  controller: 'TasklistsController'
  template: '
    <div class="tasklist">
      <h3>Title: {{tasklist.title}} ({{tasklist.tasks.finished_tasks_count}} / {{tasklist.tasks.total_tasks_count}})</h3>
      <p>Description : {{tasklist.description}}</p>
      
      Created by {{username(tasklist.user_id)}}
      Status: {{tasklist.tasks.status}}


      <button ng-hide="isAddingNewTask" ng-click="showNewTaskForm()">Create new task</button>
      <form ng-show="isAddingNewTask">
        <div ng-show="error">{{error}}</div>
        <input type="text" placeholder="Title" ng-model="newTaskTitle" required="true" ng-minlength="4" />
        <select ng-model="newTaskAssignedUserId" ng-options="o.id as o.display_name for o in users"></select>
        <button ng-click="create()">Submit</button>
      </form>
      <div ng-show="hasTasks()">
        <a ng-click="fetchTasks()">Show</a>
        <li ng-repeat="task in tasks">
          <todo task="task" tasklist="tasklist"/>
        </li>
      </div>
    </div>
  '

app.controller "TaskController", ($rootScope, $scope, Task, Todo)->
  $scope.users = $rootScope.getUsers()
  $scope.username = $rootScope.username

  $scope.editMode = ->
    $scope.isEditing = true
    $scope.originalTitle = $scope.task.title
    $scope.originalUserID = $scope.task.user_id

  $scope.update = ->
    $scope.error = ''
    Task.update(
      task_list_id: $scope.tasklist.id
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
      task_list_id: $scope.tasklist.id
      id: $scope.task.id
      ,
      cancel: $scope.task.finished

      , (response) ->
        $scope.task.finished = response.finished
      , (errRes) ->
        alert 'something strange happened'
    )

  $scope.destroy = (id) ->
    if confirm 'Are you sure that you want to delete this task?'
      Task.delete(
        task_list_id: $scope.tasklist.id
        id: $scope.task.id
      , (response)->
        $rootScope.refresh()
      )


app.directive 'todo', ($rootScope) ->
  restrict: 'E'
  scope: {
    'task': '='
    'tasklist': '='
  }
  replace: true
  controller: 'TaskController'
  template: '
    <div>
      <div ng-hide="isEditing">
        <a ng-click="toggleStatus()">Toggle</a>
        {{task.title}}
        <div ng-show="task.user_id">
          ==> {{username(task.user_id)}} is assigned
        </div>
        <div ng-show="task.finished">Finished</div>
        <div ng-hide="task.finished">Not finished yet</div>
        <a ng-click="editMode()">EDIT</a>
        <a ng-click="destroy()">DELETE</a>
      </div>
      <form ng-show="isEditing">
        <div ng-show="error">{{error}}</div>
        <input type="text" placeholder="Title" ng-model="task.title" required="true" />
        <select ng-model="task.user_id" ng-options="o.id as o.display_name for o in users"></select>
        <button ng-click="update()">Submit</button>
        <button ng-click="cancelEditing()">Cancel</button>
      </form>
    </div>
  '