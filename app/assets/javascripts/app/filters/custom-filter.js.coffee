angular.module('customFilters', [])
  .filter('displayTodoByStatus', ->
    return (array, param = 'all')->
      if param != 'all'
        ret = []
        for elem in array
          if elem.tasks.status == param
            ret.push(elem)
        return ret
      return array
  )

