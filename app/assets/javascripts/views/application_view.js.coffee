class FamilyMe.Views.ApplicationView extends Backbone.View

  initialize: (options)->
    super options

    @wallView = new FamilyMe.Views.WallView(collection: new FamilyMe.Collections.Posts())
    @usersView = new FamilyMe.Views.UsersView(collection: new FamilyMe.Collections.Users())

    FamilyMe.CurrentUser.id = $('#current-user-informations').data('id')

  bindNavigation:->
    $('ul.nav.nav-tabs li').bind 'click', (event)->
      target = $(event.currentTarget)
      target.addClass('active').siblings().removeClass('active')
      $(target.data('target')).show().siblings().hide()

  render: ->
    @usersView.render()
    @wallView.render().$el.hide()

    @bindNavigation()
