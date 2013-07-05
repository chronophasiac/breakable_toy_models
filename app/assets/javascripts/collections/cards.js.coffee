class Memworks.Collections.Cards extends Backbone.Collection

  initialize: (options={}) ->
    @challengeID = options.challengeID || null
    @currentCard = 0

  model: Memworks.Models.Card

  url: ->
   "/challenges/#{@challengeID}/cards"

  nextCard: ->
    @currentCard++
    if @remainingCards() > 0
      @trigger('showNewCard')
    else
      @trigger('completeChallenge')

  resetCardIndex: ->
    @currentCard = 0

  remainingCards: ->
    @length - @currentCard
