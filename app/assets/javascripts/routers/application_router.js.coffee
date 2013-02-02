class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family'  : 'displayApplication'

  displayApplication:->
    @applicationView ||= new FamilyMe.Views.ApplicationView()
    
    @applicationView.render()
