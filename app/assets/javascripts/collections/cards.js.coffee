class Memworks.Collections.Cards extends Backbone.Collection

  initialize: (options={}) ->
    @challenge_id = options.challenge_id || null
    @lesson_id = options.lesson_id || null
    @user_id = options.user_id || null
    @currentCard = 0
    @.on('sync', @resetCardIndex)

  model: Memworks.Models.Card

  url: ->
    if @challenge_id?
      "/challenges/#{@challenge_id}/cards"
    else if @user_id?
      "/users/#{@user_id}/cards"
    else
      "/cards"

  nextCard: ->
    @currentCard++
    if @remainingCards() > 0
      @trigger('showNewCard')
    else
      if @challenge_id?
        @trigger('completeChallenge')
      else
        @trigger('completeDeck')

  resetCardIndex: ->
    @currentCard = 0

  remainingCards: ->
    @length - @currentCard
