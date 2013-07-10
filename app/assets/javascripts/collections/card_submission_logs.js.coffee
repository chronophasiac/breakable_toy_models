class Memworks.Collections.CardSubmissionLogs extends Backbone.Collection

  initialize: (options={}) ->
    @cardID = options.cardID || null
    @ChallengeCompletion = options.ChallengeCompletion || null
    @.on('add', @updateCompletion)

  model: Memworks.Models.CardSubmissionLog

  url: ->
   "/cards/#{@cardID}/card_submission_logs"

  updateCompletion: (cardSubmissionLog) ->
    correct = cardSubmissionLog.get('correct')
    @average = cardSubmissionLog.get('average')
    @ChallengeCompletion.updateScore(correct) if @ChallengeCompletion
    if correct
      @trigger('correctAnswerSupplied')
    else
      @trigger('incorrectAnswerSupplied')

  postCompletion: ->
    @ChallengeCompletion.save()
