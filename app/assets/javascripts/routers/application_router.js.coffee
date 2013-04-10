class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'posts'     : 'displayWall'
    'positions' : 'displayFamilyMembersMap'

  displayWall:->
    FamilyMe.CurrentUser.id = $('#current-user-informations').data('id')

    $('li.wall-list').addClass('active')

    FamilyMe.UsersList = @collection = new FamilyMe.Collections.Users()
    @applicationView ||= new FamilyMe.Views.ApplicationView(collection:@collection, 'WallView')
