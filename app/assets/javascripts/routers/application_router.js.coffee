class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'posts'           : 'displayWall'
    'positions'       : 'displayFamilyMembersMap'
    'users'           : 'displayUsersListing'

  displayWall:->
    @displayForThisView('WallView')

  displayFamilyMembersMap:->
    @displayForThisView('UsersPositionsView')

  displayForThisView: (viewType)->
    FamilyMe.CurrentUser.id = $('#current-user-informations').data('id')
    FamilyMe.UsersList = @collection = new FamilyMe.Collections.Users()
    @applicationView ||= new FamilyMe.Views.ApplicationView(collection:@collection, viewType)

