app.directive "dateTimePicker", ->
  restrict: "E"
  require: ["ngModel"]
  scope:
    ngModel: "="

  replace: true
  template: "<div class=\"form-group\">" + "<div class=\"input-group\">" + "<input type=\"text\" id=\"formLeadDate\" class=\"form-control\" value=\"{{ngModel}}\">" + "<span class=\"input-group-addon\"><i class=\"glyphicon glyphicon-calendar\"></i></span>" + "</div>" + "</div>"
  link: (scope, element, attrs) ->
    input = element.find("input")
    input.datetimepicker
      format: "yyyy/mm/dd hh:ii"
      showMeridian: false
      autoclose: true
      todayBtn: true
      todayHighlight: true
      startDate: '-1y'

    element.bind "blur keyup change", ->
      scope.$apply ->
        scope.ngModel = input.val()


