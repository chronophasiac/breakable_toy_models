class Memworks.Views.CardsShow extends Backbone.View

  template: HandlebarsTemplates['cards/show']

  events:
    'submit #text-response-form': 'submitAnswer'
    'click #next': 'advanceCard'

  initialize: ->
    @collection.on('sync', @render)
    @collection.on('sync', @resetCurrentCard)
    @collection.on('showNewCard', @render)
    @logs = new Memworks.Collections.CardSubmissionLogs()
    @logs.on('add', @displayFeedback)
    setInterval(@incrementElapsedTime, 1000)

  render: =>
    @card = @collection.at(@collection.currentCard)
    @card.on("change:correct_answer", @render)
    $(@el).html(@template(card: @card.toJSON()))
    @elapsedTime = 0
    this

  incrementElapsedTime: =>
    @elapsedTime++

  displayFeedback: (cardSubmissionLog) =>
    @card.set({'responded': true})
    if cardSubmissionLog.get('correct')
      @card.set({'correct_answer': true})
    else
      @card.set({'correct_answer': false})

  submitAnswer: (event) ->
    event.preventDefault()
    attributes =
      answer: $("#string-response").val()
      card_submission_log:
        time_taken: @elapsedTime
    @logs.cardID = @card.id
    @logs.create attributes,
      wait: true
      success: -> $("#text-response-form")[0].reset()
      error: -> @handleError

  handleError: (log, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        $(@el).append("#{attribute} #{message}") for message in messages

  advanceCard: (event) ->
    event.preventDefault()
    @collection.nextCard()

  resetCurrentCard: =>
    if @collection?
      @collection.resetCardIndex
