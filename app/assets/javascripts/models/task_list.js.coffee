class FamilyMe.Models.TaskList extends Backbone.Model
  schema:
    title: {
      validators:
        checkLength: (value, formValues)->
          if (value.trim().length < 4)
            return {type: 'title', message: 'Must be 4 characters long minimum'}
    }
    description: 'TextArea'

  getTitle: ->  
    @get 'title'
  getDescription: ->
    @get 'description'
  getAuthorName: ->
    @get('author').display_name
  getTotalTasks: ->
    @get('tasks').total_tasks_count
  getFinishedTasksNumber:->
    @get('tasks').finished_tasks_count
  getStatus:->
    @get('tasks').status

  getRowClass:->
    status = @getStatus()

