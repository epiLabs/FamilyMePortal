#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require underscore
#= require backbone
#= require family_me
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

$ ->
  FamilyMe.applicationRouter = new FamilyMe.Routers.ApplicationRouter()

  # Initialize state
  Backbone.history.start(pushState: true)
