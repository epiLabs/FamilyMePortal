app.factory "Position", ($resource, apiPrefix) ->
  $resource( apiPrefix + "/positions/:collectionMethod:id", 
    id: "@id",
    collectionMethod: "@collectionMethod"
  ,
    latest:
      method: "GET"
      isArray: true
      params:
        collectionMethod: "latest"
  )
