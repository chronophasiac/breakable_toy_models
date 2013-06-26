class Memworks.Collections.Cards extends Backbone.Collection

  initialize: (options={}) ->
    @challengeID = options.challengeID || null

  url: ->
   "/challenges/#{@challengeID}/cards"
