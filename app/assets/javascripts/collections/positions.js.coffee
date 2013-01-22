class FamilyMe.Collections.Positions extends Backbone.Collection
  model: FamilyMe.Models.Position

  initialize: (options)->
    super options

    console.log 'INSTANCIATED A COLLECTION CORRECTLY'
