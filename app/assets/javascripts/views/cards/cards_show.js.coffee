class Memworks.Views.CardsShow extends Backbone.View

  template: HandlebarsTemplates['cards/show']

  events:
    'submit #text-response-form': 'submitAnswer'
    'click #position-submit':     'submitAnswer'
    'click #next':                'advanceCard'
    'click .click-response':      'snippetClick'

  initialize: ->
    @collection.on('sync', @render)
    @collection.on('sync', @resetCurrentCard)
    @collection.on('showNewCard', @cardChanged)
    @logs = new Memworks.Collections.CardSubmissionLogs()
    @logs.on('add', @displayFeedback)
    setInterval(@incrementElapsedTime, 1000)
    @cardChanged()

  render: =>
    $(@el).html(@template(card: @card.toJSON(), positions: @positions.toJSON()))
    @elapsedTime = 0
    this

  snippetClick: (event) ->
    @card.set({'responded': true})
    position = new Memworks.Models.Position()
    index = $(event.currentTarget).attr("id")
    index = index.substring(8)
    a = @card.get('tokenized_snippet')
    a[index].selected = true
    @card.set('tokenized_snippet', a)
    position.set({'position': index})
    @positions.add(position)

  incrementElapsedTime: =>
    @elapsedTime++

  displayFeedback: (cardSubmissionLog) =>
    @card.set({'submitted': true})
    if cardSubmissionLog.get('correct')
      @card.set({'correct_answer': true})
    else
      @card.set({'correct_answer': false})

  getAnswer: =>
    if @card.get('kind') == "type"
      $("#string-response").val()
    else
      @positions

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

  advanceCard: (event) ->
    event.preventDefault()
    @collection.nextCard()

  cardChanged: =>
    @card = @collection.at(@collection.currentCard)
    @card.on('positionAdded', @render)
    @card.on('change:correct_answer', @render)
    @card.on('change:submitted', @render)
    @card.on('change:responded', @render)
    @positions = @card.positions
    @positions.on('add', @render)
    @render()

  resetCurrentCard: =>
    if @collection?
      @collection.resetCardIndex
