class FamilyMe.Views.ApplicationView extends Backbone.View

  initialize: (options)->
    super options

    FamilyMe.CurrentUser.id = $('#current-user-informations').data('id')

  bindNavigation:->
    $('ul.nav.nav-tabs li').bind 'click', (event)=>
      target = $(event.currentTarget)
      target.addClass('active').siblings().removeClass('active')
      $(target.data('target')).show().siblings().hide()

      if target.data('target') == "#members-positions-container"
        @usersView().refreshMap()

  wallView:->
    @_wallView ||= new FamilyMe.Views.WallView(collection: new FamilyMe.Collections.Posts())

  usersView:->
    @_usersView ||= new FamilyMe.Views.UsersView(collection: FamilyMe.UsersList)

  render: ->
    @usersView().render().$el.hide()

    @wallView().render().$el.hide()

    @bindNavigation()