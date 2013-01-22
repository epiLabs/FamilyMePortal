class FamilyMe.Views.PositionsView extends Backbone.View
  template: JST['positions/show']
  el: '#positions_container'
  mapOptions:
    center: new google.maps.LatLng(50, 4),
    zoom: 3,
    mapTypeId: google.maps.MapTypeId.ROADMAP

  initialize: (options)->
    super options

    @collection ||= new FamilyMe.Collections.Positions()

    @collection.fetch()

  googleMapObject: ->
    @_map ||= new google.maps.Map(@$('#google_map')[0], @mapOptions)

  render: ->
    @$el.html(@template())

    @googleMapObject()

    # @collection.forEach (model, idx)->
    #   console.log model, idx

    @