class Memworks.Views.ChallengesShow extends Backbone.View

  template: HandlebarsTemplates['challenges/show']

  initialize: ->
    @collection.on('sync', @render)

  render: =>
    $(@el).html(@template(cards: @collection.toJSON()))
    this
