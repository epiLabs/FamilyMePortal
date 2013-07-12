app.factory "Todo", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/task_lists/:id", 
    id: "@id"
  ,
    update:
      method: "PUT"
  )
