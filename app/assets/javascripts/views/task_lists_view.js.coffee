class FamilyMe.Views.TaskListsView extends Backbone.View
  template: JST['task-lists/index']
  el: '#display-task-lists'
  events:
    'click .modal-footer .btn-success' : 'createTaskList'

  createTaskList: (event)->
    errors = @form.commit()

    unless errors
      @collection.create @form.model.attributes, {wait: true}
      @form.model.clear()
      $('#new-task-list-modal').modal('hide')

  initialize: (options)->
    super options

    @collection = new FamilyMe.Collections.TaskLists()

    @collection.fetch
      success: =>
        @render()

    @collection.bind 'add', (model)=>
      @render()

  render: ->
    @form ||= new Backbone.Form(model: new FamilyMe.Models.TaskList())

    @$el.html(@template(collection: @collection))

    @$('.modal-body').append @form.render().el
    @

