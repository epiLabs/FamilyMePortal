class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family' : 'displayApplication'

  displayApplication: ->
    @positonsView ||= new FamilyMe.Views.PositionsView()
