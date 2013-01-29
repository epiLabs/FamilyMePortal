class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family' : 'displayApplication'

  displayApplication: ->
    @usersView ||= new FamilyMe.Views.UsersView(collection: new FamilyMe.Collections.Users())
