class Memworks.Views.CardsError extends Backbone.View

  template: HandlebarsTemplates['cards/error']

  render: =>
    $(@el).html(@template())
    this
