class FamilyMe.Models.Event extends Backbone.Model
  schema:
    title: {
      validators:
        checkLength: (value, formValues)->
          if (value.trim().length < 3)
            return {type: 'title', message: 'Must be 3 characters long minimum'}
    }
    start_date: {
      type: 'DateTime',
      validators:
        checkValue: (value, formValues)->
          end_date = formValues.end_date

          if (Date.parse(end_date) < Date.parse(value))
            return {type: 'start_date', message: 'Start date must be lower than end date'}
    }
    end_date:   'DateTime'
    description: 'TextArea'

  initialize: (model, options)->
    super model, options

    @user = FamilyMe.UsersList.get(@get 'user_id')

  getAuthor:->
    @user.getTitle()

  getAuthorAvatarUrl:->
    @user.getAvatarUrl()

  getTitle:->
    @get 'title'
  getStartDate:->
    @get('start_date')
  getEndDate:->
    @get 'end_date'
  getDescription:->
    @get 'description'
  getDuration:->
    diff = moment(@getEndDate()) - moment(@getStartDate())

    moment.duration(diff).humanize()

  getBeginCount:->
    moment(@getStartDate()).fromNow()
