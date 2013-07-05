class Memworks.Models.ChallengeProgression extends Backbone.Model

  initialize: ->
    @.set({'score': 0})

  updateScore: (correct) ->
    if correct
      score = @.get('score')
      @.set({'score': score + 1})
