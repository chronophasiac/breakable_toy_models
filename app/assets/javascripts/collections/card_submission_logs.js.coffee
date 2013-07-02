class Memworks.Collections.CardSubmissionLogs extends Backbone.Collection

  initialize: (options={}) ->
    @cardID = options.cardID || null

  model: Memworks.Models.CardSubmissionLog

  url: ->
   "/cards/#{@cardID}/card_submission_logs"
