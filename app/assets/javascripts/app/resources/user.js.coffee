app.factory "User", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/users/:id", 
    id: "@id"
  )

