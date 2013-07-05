class Memworks.Models.ChallengeCompletion extends Backbone.Model

  initialize: (options={}) ->
    @challenge_id = options.challenge_id || null
    @.set({'score': 0})

  paramRoot: 'challenge_completion'

  url: ->
   "/challenges/#{@challenge_id}/challenge_completions"

  updateScore: (correct) ->
    if correct
      score = @.get('score')
      @.set({'score': score + 1})
