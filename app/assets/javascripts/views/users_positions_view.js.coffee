class FamilyMe.Views.UsersPositionsView extends Backbone.View
  template: JST['positions/index']
  el: '#members-positions-container'

  initialize: (options)->
    super options

    @collection = FamilyMe.UsersList
    
    @latitude = $('#members-positions-container').data('center-latitude') || 0
    @longitude = $('#members-positions-container').data('center-longitude') || 0

  getMapOptions: ->
    @mapCenter = new google.maps.LatLng(@latitude, @longitude)
    mapOptions =
      center: @mapCenter
      zoom: 5
      mapTypeId: google.maps.MapTypeId.ROADMAP

  googleMapObject: ->
    @_map ||= new google.maps.Map(@$('#google_map')[0], @getMapOptions())

  refreshMap:->
    google.maps.event.trigger(@googleMapObject(), 'resize')
    @googleMapObject().setCenter(@mapCenter)

  render: ->
    @$el.html(@template())

    if @latitude? && @longitude?
      @collection.forEach (model, idx)=>
        view = new FamilyMe.Views.UserPositionView(model: model, map: @googleMapObject())
        view.render()
    @
