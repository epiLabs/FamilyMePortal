class FamilyMe.Views.UsersView extends Backbone.View
  template: JST['users/index']
  el: '#members-positions-container'

  initialize: (options)->
    super options

    self = @
    @latitude = $('#members-positions-container').data('center-latitude')
    @longitude = $('#members-positions-container').data('center-longitude')

    if @latitude? && @longitude?
      @collection.fetch
        success: (user, response, options)->
          self.render()

  getMapOptions: ->
    mapOptions =
      center: new google.maps.LatLng(@latitude, @longitude)
      zoom: 5
      mapTypeId: google.maps.MapTypeId.ROADMAP

  googleMapObject: ->
    @_map ||= new google.maps.Map(@$('#google_map')[0], @getMapOptions())

  render: ->
    @$el.html(@template())

    @collection.forEach (model, idx)=>
      view = new FamilyMe.Views.UserView(model: model, map: @googleMapObject())
      view.render()

    @