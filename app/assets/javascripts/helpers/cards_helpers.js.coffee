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

Handlebars.registerHelper('render_average', ->
  if @average?
    new Handlebars.SafeString(
      "<section class='score-container panel'>
  <h5>Your average performance on the previously submitted card:</h5>
  <h5 class='subheader' id='average'>#{Math.round(this.average * 100)}%</h5>
  <div class='progress'><span class='meter' style='width:#{this.average * 100}%'></span></div>
  </section>")
  )
