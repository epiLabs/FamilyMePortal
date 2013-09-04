app.factory "Event", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/events/:id", 
    id: "@id"
  ,
    update:
      method: "PUT"
  )
