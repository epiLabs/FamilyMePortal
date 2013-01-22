class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family' : 'displayApplication'

  displayApplication: ->
    @positionsView ||= new FamilyMe.Views.PositionsView()

    @positionsView.render()