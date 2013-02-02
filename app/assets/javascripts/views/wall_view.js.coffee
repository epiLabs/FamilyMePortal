class FamilyMe.Views.WallView extends Backbone.View
  template: JST['wall/index']
  el: '#posts'
  events:
    'submit .new-post form' : 'submitNewPost'
    'click .display-form-button' : 'showNewPostForm'

  initialize: (options)->
    super options

    @collection.bind 'add', (model)=>
      postView = new FamilyMe.Views.PostView(model: model)
      @$('.posts-list').prepend postView.render().el

    @collection.fetch update: true

  submitNewPost: (event)->
    message = @$('.new-post textarea').val()

    if message.length
      @collection.create {message: message}, {wait: true}

    false

  showNewPostForm: (event)->
    @$('.new-post').show()
    @$('.display-form-button').hide()

  hideNewPostForm: (event)->
    @$('.new-post').hide()

  render: ->
    @$el.html(@template())

    @hideNewPostForm()

    @