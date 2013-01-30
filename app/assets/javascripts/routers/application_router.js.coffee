class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family'  : 'displayApplication'
    'posts'   : 'displayWall'

  displayApplication: ->
    @usersView ||= new FamilyMe.Views.UsersView(collection: new FamilyMe.Collections.Users())

  displayWall:->
    @wallView ||= new FamilyMe.Views.WallView(collection: new FamilyMe.Collections.Posts())

    @wallView.render()
