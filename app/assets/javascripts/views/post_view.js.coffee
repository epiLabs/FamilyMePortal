class FamilyMe.Views.PostView extends Backbone.View
  template: JST['post/show']

  render: ->
    @$el.html(@template(model: @model))

    # I had to use JQuery instead of the generic event gestion
    # because we an issue with event listening after the wall got re-rendered
    @$('.delete-post').click =>
      if confirm 'Are you sure you want to delete this post?'
        @model.destroy()
    @
