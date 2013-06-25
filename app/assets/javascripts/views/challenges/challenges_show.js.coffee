class Memworks.Views.ChallengesShow extends Backbone.View

  template: HandlebarsTemplates['challenges/show']

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(model: @model))
    this
