class Memworks.Collections.Cards extends Backbone.Collection

  initialize: (options={}) ->
    @challengeID = options.challengeID || null
    @currentCard = 0

  url: ->
   "/challenges/#{@challengeID}/cards"

  nextCard: ->
    @currentCard++
    @trigger('showNewCard')

  resetCardIndex: ->
    @currentCard = 0
