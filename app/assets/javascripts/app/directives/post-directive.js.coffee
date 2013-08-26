app.directive 'post', ($rootScope) ->
  restrict: 'E'
  scope: true
  replace: true
  template: '
    <div class="post media">
      <div class="avatar pull-left">
        <img ng-src="{{avatarUrl(post.user_id)}}" class="media-object" />
      </div>
      
      <div class="media-body">
        <h5 class="media-heading">{{username(post.user_id)}}</h5>
        <p>{{post.message}}</p>
        <div>
          <a class="edit-post"ng-show="canEdit(post.user_id)" href="/posts/{{post.id}}/edit">Edit</a>
          <a class="delete-post" ng-show="canDelete(post.user_id)" href="" ng-click="destroy(post.id)">&times</a>
        </div>
      </div>
    </div>
  '
