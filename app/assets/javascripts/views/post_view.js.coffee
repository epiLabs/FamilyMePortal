class FamilyMe.Views.PostView extends Backbone.View
  template: JST['post/show']
  events:
    'click .delete-post' : 'deletePost'
    'mouseenter' : 'displayDeleteButton'
    'mouseleave' : 'hideDeleteButton'

  initialize: (options)->
    super options

    @model.bind 'destroy', ()=> @remove()

  displayDeleteButton: (event)->
    if @model.canBeDeleted()
      @$('.delete-post').show()

  hideDeleteButton: (event)->
    if @model.canBeDeleted()
      @$('.delete-post').hide()

  deletePost: (event)->
    if confirm 'Are you sure you want to delete this post?'
      @model.destroy()

  render: ->
    @$el.html(@template(model: @model))

    @hideDeleteButton()
    @
