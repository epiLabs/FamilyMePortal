class FamilyMe.Views.UserView extends Backbone.View

  initialize: (options)->
    super options
    
    @collection = FamilyMe.UsersList
    @map = options.map

  placeMapMarker:->
    latlng = new google.maps.LatLng(@model.position.getLatitude(), @model.position.getLongitude())
    @marker = new google.maps.Marker
      position: latlng
      map: @map
      title: @model.getTitle()

  createInfoWindow:->
    @infowindow = new google.maps.InfoWindow(content: JST['users/show'](model: @model))

    google.maps.event.addListener @marker, 'click', =>
      @infowindow.open(@map, @marker)

  render: ->
    @placeMapMarker()
    @createInfoWindow()
    @
