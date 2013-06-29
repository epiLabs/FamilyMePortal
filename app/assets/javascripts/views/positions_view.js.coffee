class FamilyMe.Views.PositionsView extends Backbone.View
  template: JST['positions/index']
  el: '#display-positions'
  events:
    'shown' : 'refreshMap'

  initialize: (options)->
    super options

    # TODO : Change to be able to change it into someone's positions
    @collection = FamilyMe.UsersList
    
    @latitude = 0
    @longitude = 0

  getMapOptions: ->
    @mapCenter = new google.maps.LatLng(@latitude, @longitude)
    mapOptions =
      center: @mapCenter
      zoom: 5
      mapTypeId: google.maps.MapTypeId.ROADMAP

  googleMapObject: ->
    @_map ||= new google.maps.Map(@$('#google_map')[0], @getMapOptions())

  refreshMap:->
    unless @called
      @called = true
      google.maps.event.trigger(@googleMapObject(), 'resize')
      @googleMapObject().setCenter(@mapCenter)

  render: ->
    @$el.html(@template())

    if @latitude? && @longitude?
      @collection.forEach (model, idx)=>
        if model.position
          view = new FamilyMe.Views.PositionView(model: model, map: @googleMapObject())
          view.render()
    @
