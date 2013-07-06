class Memworks.Views.CardsShow extends Backbone.View

  template: HandlebarsTemplates['cards/show']

  events:
    'submit #text-response-form':   'submitAnswer'
    'click #position-submit':       'submitAnswer'
    'click #next':                  'advanceCard'
    'click .click-response':        'snippetClick'

  initialize: ->
    @collection.on('showNewCard', @cardChanged)
    @collection.on('completeChallenge', @challengeSummary)
    @collection.on('completeDeck', @completeDeck)
    if @model
      @logs = new Memworks.Collections.CardSubmissionLogs({ChallengeCompletion: @model})
    else
      @logs = new Memworks.Collections.CardSubmissionLogs()
    @logs.on('correctAnswerSupplied', @displayCorrect)
    @logs.on('incorrectAnswerSupplied', @displayIncorrect)
    setInterval(@incrementElapsedTime, 1000)
    @cardChanged()

  render: =>
    if @model
      $(@el).html(@template(
                  card: @card.toJSON()
                  score: @model.get('score')
                  remaining: @collection.remainingCards()))
    else
      $(@el).html(@template(
                  card: @card.toJSON()
                  remaining: @collection.remainingCards()))
    $('input#string-response').focus()
    this

  snippetClick: (event) ->
    @card.set({'responded': true})
    index = $(event.currentTarget).attr("id").substring(8)
    @card.clickPosition(index)

  incrementElapsedTime: =>
    @elapsedTime++

  displayCorrect: =>
    @card.set({'correct_answer': true})

  displayIncorrect: =>
    @card.set({'incorrect_answer': true})

  getAnswer: =>
    if @card.get('kind') == "type"
      $("#string-response").val()
    else
      @card.selectedPositions()

  submitAnswer: (event) ->
    event.preventDefault()
    attributes =
      answer: @getAnswer()
      card_submission_log:
        time_taken: @elapsedTime
    @logs.cardID = @card.id
    @logs.create attributes,
      wait: true
      error: -> @handleError

  handleError: (log, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        $(@el).append("#{attribute} #{message}") for message in messages
    else
      $(@el).html("An error has occurred")

  advanceCard: (event) ->
    event.preventDefault()
    @collection.nextCard()

  cardChanged: =>
    @card = @collection.at(@collection.currentCard)
    @card.on('change', @render)
    @elapsedTime = 0
    @render()

  challengeSummary: =>
    @logs.postCompletion()
    summaryTemplate = HandlebarsTemplates['challenges/summary']
    $(@el).html(summaryTemplate(
                score: @model.get('score')
                lesson_id: @collection.lesson_id
                challenge_id: @collection.challenge_id))
    
  completeDeck: =>
    summaryTemplate = HandlebarsTemplates['cards/summary']
    $(@el).html(summaryTemplate())
