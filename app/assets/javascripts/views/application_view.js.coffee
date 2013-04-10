class FamilyMe.Views.ApplicationView extends Backbone.View

  initialize: (options, viewType)->
    super options

    obj = {WallView: FamilyMe.Views.WallView}

    @collection.fetch
      success: (user, response, options)=>
        @view = new obj[viewType]()
        # @view = new FamilyMe.Views.WallView(collection: new FamilyMe.Collections.Posts())
        @render()
      error:->
        alert 'Error loading application... Try to reload this page!'

  render: ->
    @view.render()

    @
