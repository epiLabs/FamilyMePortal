class FamilyMe.Models.User extends Backbone.Model

  initialize: (model, options)->
    super model, options

    @position = new FamilyMe.Models.Position(@get 'position')

  selectAsCurrentUser:->
    @_isCurrentUser = true

  getFirstName:->
    @get 'first_name'
  getLastName:->
    @get 'last_name'
  getNickName:->
    @get 'nickname'

  getTitle: ->
    title = ""

    if @_isCurrentUser
      return "It's you !"

    if @getFirstName()
      title += @getFirstName() + " "

    if @getLastName()
      title += @getLastName() + " "

    if @getNickName()
      title += "(#{@getNickName()})"

    title || "Some member of your family"