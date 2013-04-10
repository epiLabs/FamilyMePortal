class FamilyMe.Views.WallView extends Backbone.View
  template: JST['wall/index']
  el: '#posts'
  events:
    'submit .new-post form' : 'submitNewPost'
    'click .display-form-button' : 'showNewPostForm'

  initialize: (options)->
    super options

    @collection = new FamilyMe.Collections.Posts()

    # Keep this line to build the postViews array before binding the collection
    @postViews()

    @collection.bind 'add', (model)=>
      postView = new FamilyMe.Views.PostView(model: model)
      @registerPostView(postView)
      @postViews().push(postView)

      @$('.posts-list').prepend postView.render().el

    @collection.fetch update: true

  submitNewPost: (event)->
    message = @$('.new-post textarea').val()

    if message.length
      @collection.create {message: message, user_id: FamilyMe.CurrentUser.id}, {wait: true}
      @$('.new-post textarea').val('')
      @hideNewPostForm()

    false

  removePost: (post)=>
    postView = null
    @_postViews = _.reject @_postViews, (item)->
      if item.model == post
        postView = item
    postView.remove()
    @render()

  registerPostView: (postView)->
    postView.model.bind "destroy", @removePost
  postViews:->
    unless @_postViews
      @_postViews = _.map @collection.models, (post)=>
        postView = new FamilyMe.Views.PostView(model: post)
        @registerPostView(postView)
        postView

    @_postViews

  showNewPostForm: (event)->
    @$('.new-post').show()
    @$('.display-form-button').hide()

  hideNewPostForm: (event)->
    @$('.new-post').hide()
    @$('.display-form-button').show()

  render: ->
    @$el.html(@template())
    @hideNewPostForm()

    for view in @postViews()
      @$('.posts-list').prepend view.render().el
    @
