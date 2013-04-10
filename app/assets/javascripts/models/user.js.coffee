class FamilyMe.Models.User extends Backbone.Model

  initialize: (model, options)->
    super model, options

    if @get 'position'
      @position = new FamilyMe.Models.Position(@get 'position')

    if FamilyMe.CurrentUser.id == @get 'id'
      @_isCurrentUser = true  

  isCurrentUser:->
    @_isCurrentUser?

  getFirstName:->
    @get('first_name') || "John"
  getLastName:->
    @get('last_name') || "Doe"
  getNickName:->
    @get('nickname') || "NicknameLess"
  getLastConnection:->
    @get 'last_sign_in'

  getTitle: ->
    title = ""

    if @_isCurrentUser
      return "It's you !"

    "#{@getFirstName()} #{@getLastName()} (#{@getNickName()})"
