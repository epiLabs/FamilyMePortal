class FamilyMe.Views.PositionView extends Backbone.View

  initialize: (options)->
    super options
    
    @map = options.map

  placeMapMarker:->
    latlng = new google.maps.LatLng(@model.position.getLatitude(), @model.position.getLongitude())
    @marker = new google.maps.Marker
      position: latlng
      map: @map
      icon: @model.getAvatarUrl()
      title: @model.getTitle()

  createInfoWindow:->
    @infowindow = new google.maps.InfoWindow(content: JST['positions/show'](model: @model))

    google.maps.event.addListener @marker, 'click', =>
      @infowindow.open(@map, @marker)

  render: ->
    @placeMapMarker()
    @createInfoWindow()
    @
