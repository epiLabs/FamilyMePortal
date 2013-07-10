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
      <a ng-show="canEdit(post.user_id)" href="/posts/{{post.id}}/edit">Edit</a>
      <a ng-show="canDelete(post.user_id)" href="" ng-click="destroy(post.id)">&times</a>
    </div>
  '

  link: (scope, iElement, iAttrs) ->
    scope.username = (user_id)->
      scope.getUser(user_id).display_name
    scope.avatarUrl = (user_id)->
      scope.getUser(user_id).avatar_url
