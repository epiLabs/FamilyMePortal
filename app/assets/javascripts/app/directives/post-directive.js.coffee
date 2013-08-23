app.directive 'post', ($rootScope) ->
  restrict: 'E'
  scope: true
  replace: true
  template: '
    <div class="post">
      <div class="avatar">
        <img ng-src="{{avatarUrl(post.user_id)}}" />
      </div>
      
      {{username(post.user_id)}}
      Message: {{post.message}} <br/>
      <a class="edit-post"ng-show="canEdit(post.user_id)" href="/posts/{{post.id}}/edit">Edit</a>
      <a class="delete-post" ng-show="canDelete(post.user_id)" href="" ng-click="destroy(post.id)">&times</a>
    </div>
  '
