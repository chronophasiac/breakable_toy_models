class Memworks.Models.ChallengeProgression extends Backbone.Model

  initialize: (options={}) ->
    @challenge_id = options.challenge_id || null
    @.set({'score': 0})

  paramRoot: 'challenge_progression'

  url: ->
   "/challenges/#{@challenge_id}/challenge_progressions"

  updateScore: (correct) ->
    if correct
      score = @.get('score')
      @.set({'score': score + 1})
