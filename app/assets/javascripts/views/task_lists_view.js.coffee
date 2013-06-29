class FamilyMe.Views.TaskListsView extends Backbone.View
  template: JST['task-lists/index']
  el: '#display-task-lists'
  events:
    'click .modal-footer .btn-success' : 'createTaskList'

  createTaskList: (event)->
    errors = @form.commit()

    unless errors
      console.log "SUCCESS"
      # @collection.create @form.model.attributes, {wait: true}
      # @form.model.clear()
      # $('#new-event-modal').modal('hide')

      # @render()

  initialize: (options)->
    super options

    @collection = new FamilyMe.Collections.TaskLists()

    @collection.fetch
      success: ->
        console.log 'Task list loaded'
      error: ->
        console.log 'An error has occured'


  render: ->
    @form ||= new Backbone.Form(model: new FamilyMe.Models.TaskList())

    @$el.html(@template())

    @$('.modal-body').append @form.render().el

    @

