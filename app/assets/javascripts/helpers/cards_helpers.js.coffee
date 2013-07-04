Handlebars.registerHelper('selected_position', (context) ->
  if context.selected then "selected-position" else ""
  )
