class FamilyMe.Views.PositionsView extends Backbone.View
  template: JST['positions/show']
  el: '#positions_container'

  initialize: (options)->
    super options

    @collection ||= new FamilyMe.Collections.Positions()

    self = @
    @collection.fetch
      success: (position, response, options)->
        self.render()

  getMapOptions: ->
    latitude = $('#positions_container').data('center-latitude')
    longitude = $('#positions_container').data('center-longitude')
    mapOptions =
      center: new google.maps.LatLng(latitude, longitude)
      zoom: 5
      mapTypeId: google.maps.MapTypeId.ROADMAP

  placeMapMarker: (latitude, longitude, title)->
    latlng = new google.maps.LatLng(latitude, longitude);

    marker = new google.maps.Marker
      position: latlng
      map: @googleMapObject()
      title: 'tamenere'

  googleMapObject: ->
    @_map ||= new google.maps.Map(@$('#google_map')[0], @getMapOptions())

  render: ->
    @$el.html(@template())

    @googleMapObject()

    @collection.forEach (model, idx)=>
      @placeMapMarker model.getLatitude(), model.getLongitude(), model.getTitle()

    @