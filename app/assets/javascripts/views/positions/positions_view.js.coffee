class FamilyMe.Views.PositionsView extends Backbone.View
  template: JST['positions/show']
  id: 'positions_container'

  initialize: (options)->
    super options

    @collection ||= new FamilyMe.Collections.Positions()

    @collection.fetch success: => @render()
      
  render: ->
    super

    @collection.forEach (model, idx)->
      console.log model, idx
