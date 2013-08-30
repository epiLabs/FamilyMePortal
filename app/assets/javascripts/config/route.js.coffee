# Configure 'app' routing. The $stateProvider and $urlRouterProvider
# will be automatically injected into the configurator.
app.config ($stateProvider, $urlRouterProvider, $rootScopeProvider) ->
 
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

    .state "posts.new",
      parent: "posts"
      url: "/new"
      views:
        "@default":
          controller: "PostsController"
          templateUrl: "/assets/posts/new.html.erb"

    .state "posts.edit",
      parent: "posts"
      url: "/:id/edit"
      views:
        "@default":
          controller: "PostsController"
          templateUrl: "/assets/posts/edit.html.erb"

    # Tasks lists
    .state "todos",
      parent: "default"
      url: "/todos"
      views:
        "":
          controller: "TodosController"
          templateUrl: "/assets/todos/index.html.erb"
    .state "todos.new",
      parent: "todos"
      url: "/new"
      views:
        "@default":
          controller: "TodosController"
          templateUrl: "/assets/todos/new.html.erb"
    .state "todos.edit",
      parent: "todos"
      url: "/:id/edit"
      views:
        "@default":
          controller: "TodosController"
          templateUrl: "/assets/todos/edit.html.erb"
    .state "todos.show",
      parent: "todos"
      url: "/:id"
      views:
        "@default":
          controller: "TodolistDetailController"
          templateUrl: "/assets/todos/show.html.erb"

    # Positions
    .state "positions",
      parent: "default"
      url: "/positions"
      views:
        "":
          controller: "PositionsController"
          templateUrl: "/assets/positions/index.html.erb"
    .state "positions.latest",
      parent: "positions"
      url: "/latest"

    # Events
    .state "events",
      parent: "default"
      url: '/events'
      views:
        "":
          controller: "EventsController"
          templateUrl: "/assets/events/index.html.erb"

