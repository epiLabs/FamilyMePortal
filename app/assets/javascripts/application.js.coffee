#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require underscore
#= require hamlcoffee
#= require backbone
#= require gravtastic
#= require family_me
#= require_tree ../templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

$ ->
  unless $('#not-in-family').length
    FamilyMe.applicationRouter = new FamilyMe.Routers.ApplicationRouter()

    # Initialize state
    Backbone.history.start(pushState: true)
