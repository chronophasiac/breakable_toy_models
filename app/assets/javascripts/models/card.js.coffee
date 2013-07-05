class Memworks.Models.Card extends Backbone.Model

  initialize: ->
    @.set({'submitted': false})
    @.set({'correct_answer': false})
    @.set({'incorrect_answer': false})
    @.on('change:correct_answer', @cardSubmitted)
    @.on('change:incorrect_answer', @cardSubmitted)

  cardSubmitted: ->
    @.set({'submitted': true})

  clickPosition: (index) ->
    snippet = @.get('tokenized_snippet')
    snippet[index].selected = !snippet[index].selected
    @.set('tokenized_snippet', snippet)
    @.trigger('change')

  selectedPositions: ->
    positions = []
    snippet = @.get('tokenized_snippet')
    for token, i in snippet
      positions.push({position: i}) if token.selected
    positions
