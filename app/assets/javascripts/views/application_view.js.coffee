class FamilyMe.Views.ApplicationView extends Backbone.View

  initialize: (options, viewType)->
    super options

    obj =
      WallView: FamilyMe.Views.WallView
      UsersPositionsView: FamilyMe.Views.UsersPositionsView

    @collection.fetch
      success: (user, response, options)=>
        @view = new obj[viewType]()
        @render()
      error:->
        alert 'Error loading application... Try to reload this page!'

  render: ->
    @view.render()

    @
