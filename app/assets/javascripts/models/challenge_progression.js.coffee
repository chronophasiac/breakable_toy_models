class Memworks.Models.ChallengeProgression extends Backbone.Model

  initialize: ->
    @.set({'score': 0})

  incrementScore: ->
    score = @.get('score')
    @.set({'score': score + 1})
