class Memworks.Collections.Cards extends Backbone.Collection

  initialize: (model, options={}) ->
    @challengeID = options.challengeID || null

  url: ->
   "/challenges/#{@challengeID}/cards"
