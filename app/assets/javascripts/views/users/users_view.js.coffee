class FamilyMe.Views.UsersView extends Backbone.View
  template: JST['users/index']
  el: '#positions_container'

  initialize: (options)->
    super options

    self = @
    @collection.fetch
      success: (user, response, options)->
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