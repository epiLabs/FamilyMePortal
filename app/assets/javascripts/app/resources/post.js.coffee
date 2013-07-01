app.factory "Post", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/posts/:id", 
    id: "@id"
  ,
    update:
      method: "PUT"
  )
