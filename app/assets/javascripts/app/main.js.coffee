# Create 'app' angular application (module)
@app = angular.module("familyMe", [
  # ngResource
  "ngResource",

  # Router
  "ui.compat",

  # Map
  'ui.map',

  #i18n
  'pascalprecht.translate',

  "customFilters"
])
