class FamilyMe.Models.Invitation extends Backbone.Model

  initialize: (model, options)->
    super model, options

  getAuthor:->
    "#{@get('inviter').first_name} #{@get('inviter').last_name}"
  getEmail:->
    @get 'email'
  getStatus:->
    @get 'status'

  getRowClass:->
    status = @get 'status'

    switch status
      when 'pending' then 'warning'
      when 'declined' then 'error'
      when 'accepted' then 'success'
