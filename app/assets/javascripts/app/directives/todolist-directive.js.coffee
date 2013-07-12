app.directive 'todolist', ($rootScope) ->
  restrict: 'E'
  scope: true
  replace: true
  template: '
    <div class="todolist">
      <h3>Title: {{todolist.title}}</h3>
      <p>Description : {{todolist.description}}</p>
      
      Created by {{username(todolist.user_id)}}
      Status: {{todolist.tasks.status}}
    </div>
  '
