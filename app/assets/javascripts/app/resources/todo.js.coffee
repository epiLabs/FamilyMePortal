app.factory "Todo", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/task_lists/:id", 
    id: "@id"
  ,
    update:
      method: "PUT"
  )

app.factory "Task", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/task_lists/:task_list_id/tasks/:id/:custom_action", 
    task_list_id: "@task_list_id"
    id: "@id"
  ,
    update:
      method: "PUT"
    finish:
      method: "GET"
      params:
        custom_action: 'finish'
  )