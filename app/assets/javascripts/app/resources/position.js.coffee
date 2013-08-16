app.factory "Position", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/positions/:id", 
    id: "@id"
  )
