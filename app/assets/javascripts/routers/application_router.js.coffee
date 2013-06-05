class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family'           : 'displayApplication'

  getUsers: ->
    @collection ||= new FamilyMe.Collections.Users($('#main-application').data('users'))

  displayApplication: ->
    FamilyMe.CurrentUser.id ||= $('#main-application').data('current-id')
    FamilyMe.UsersList ||= @getUsers()

    @applicationView ||= new FamilyMe.Views.ApplicationView(collection:@collection)

    @applicationView.render()

