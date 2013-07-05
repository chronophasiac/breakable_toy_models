class Memworks.Collections.CardSubmissionLogs extends Backbone.Collection

  initialize: (options={}) ->
    @cardID = options.cardID || null
    @challengeProgression = options.challengeProgression || null
    @.on('add', @updateProgression)

  model: Memworks.Models.CardSubmissionLog

  url: ->
   "/cards/#{@cardID}/card_submission_logs"

  updateProgression: (cardSubmissionLog) ->
    correct = cardSubmissionLog.get('correct')
    @challengeProgression.updateScore(correct) if @challengeProgression
    if correct
      @trigger('correctAnswerSupplied')
    else
      @trigger('incorrectAnswerSupplied')

  postProgression: ->
    @challengeProgression.save()
