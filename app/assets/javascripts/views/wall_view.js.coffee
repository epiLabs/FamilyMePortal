class FamilyMe.Views.WallView extends Backbone.View
  template: JST['wall/index']
  el: '#posts'

  initialize: (options)->
    super options

    @collection.bind 'add', (model)=>
      postView = new FamilyMe.Views.PostView(model: model)
      @$('.posts_list').append postView.render().el

    @collection.fetch update: true

  render: ->
    @$el.html(@template())

    @