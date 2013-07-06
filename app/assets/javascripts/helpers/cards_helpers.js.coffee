Handlebars.registerHelper('render_score', ->
  if @score?
    new Handlebars.SafeString(
      "<section class='score-container'>
  <h3>Score:</h3>
  <h3 class='subheader' id='current-score'>#{this.score}</h3>
  </section>")
  )

Handlebars.registerHelper('selected_position', ->
  if @selected then "selected-position" else ""
  )

Handlebars.registerHelper('solution_position', ->
  if @solution then "solution-position" else ""
  )
