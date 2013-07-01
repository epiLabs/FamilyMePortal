# Configure 'app' routing. The $stateProvider and $urlRouterProvider
# will be automatically injected into the configurator.
app.config ($stateProvider, $urlRouterProvider) ->
 
  # Make sure that any other request beside one that is already defined
  # in stateProvider will be redirected to root.
  $urlRouterProvider
    .otherwise("/")
 
  # Define 'app' states
  $stateProvider
    .state "default",
      abstract: true
      views:
        "":
          controller: "ApplicationController"
          templateUrl: "/assets/layouts/default.html.erb"

    # Posts
    .state "posts",
      parent: "default"
      url: "/posts"
      views:
        "":
          controller: "PostsController"
          templateUrl: "/assets/posts/index.html.erb"

    .state "new",
      parent: "posts"
      url: "/new"
      views:
        "@default":
          controller: "PostsController"
          templateUrl: "/assets/posts/new.html.erb"

    .state "edit",
      parent: "posts"
      url: "/:id/edit"
      views:
        "@default":
          controller: "PostsController"
          templateUrl: "/assets/posts/edit.html.erb"
