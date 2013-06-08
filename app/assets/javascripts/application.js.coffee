#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require underscore
#= require hamlcoffee
#= require backbone
#= require gravtastic
#= require family_me
#= require backbone-forms
#= require backbone-forms-list
#= require backbone-forms-bootstrap
#= require moment
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

$ ->
  FamilyMe.applicationRouter = new FamilyMe.Routers.ApplicationRouter()

  # Initialize state
  Backbone.history.start(pushState: true)
