class FamilyMe.Models.TaskList extends Backbone.Model
  schema:
    title: {
      validators:
        checkLength: (value, formValues)->
          if (value.trim().length < 3)
            return {type: 'title', message: 'Must be 3 characters long minimum'}
    }
    description: 'TextArea'
