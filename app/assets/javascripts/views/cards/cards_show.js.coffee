class Memworks.Views.CardsShow extends Backbone.View

  template: HandlebarsTemplates['cards/show']

  events:
    'click #next': 'nextCard'

  initialize: ->
    @collection.on('sync', @render)
    @collection.on('sync', @resetCurrentCard)
    @collection.on('showNewCard', @render)

  render: =>
    index = @collection.currentCard
    $(@el).html(@template(card: @collection.at(index).toJSON()))
    this

  nextCard: (event) ->
    event.preventDefault()
    @collection.nextCard()

  resetCurrentCard: =>
    if @collection?
      @collection.resetCardIndex
