class FamilyMe.Views.PostView extends Backbone.View
  template: JST['post/show']
  events:
    'click .delete-post' : 'deletePost'

  initialize: (options)->
    super options

    @model.bind 'destroy', ()=> @remove()

  deletePost: (event)->
    if confirm 'Are you sure you want to delete this post?'
      @model.destroy()

  render: ->
    @$el.html(@template(model: @model))

    @