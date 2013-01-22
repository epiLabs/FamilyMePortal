class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family' : 'displayApplication'

  displayApplication: ->
    @positonsView ||= new Backbone.Views.PositionsView()    
    console.log 'YEAAAAAH'
