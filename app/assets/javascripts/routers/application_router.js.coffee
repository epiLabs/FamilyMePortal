class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'posts'           : 'displayWall'
    'positions'       : 'displayFamilyMembersMap'
    'users'           : 'displayUsersListing'
    'invitations'     : 'displayInvitations'

  displayUsersListing:->
    $('li.member-list').addClass('active')

  displayWall:->
    $('li.wall-list').addClass('active')
    @displayForThisView('WallView')

  displayFamilyMembersMap:->
    $('li.position-list').addClass('active')
    @displayForThisView('UsersPositionsView')

  displayInvitations:->
    $('li.invitation-list').addClass('active')
    @displayForThisView('InvitationsView')

  displayForThisView: (viewType)->
    FamilyMe.CurrentUser.id = $('#current-user-informations').data('id')
    FamilyMe.UsersList = @collection = new FamilyMe.Collections.Users()
    @applicationView ||= new FamilyMe.Views.ApplicationView(collection:@collection, viewType)


