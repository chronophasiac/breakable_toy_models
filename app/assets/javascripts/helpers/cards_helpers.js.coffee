Handlebars.registerHelper('selected_position', ->
  if @selected then "selected-position" else ""
  )

Handlebars.registerHelper('solution_position', ->
  if @solution then "solution-position" else ""
  )
