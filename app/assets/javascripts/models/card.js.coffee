class Memworks.Models.Card extends Backbone.Model

  clickPosition: (index) ->
    snippet = @.get('tokenized_snippet')
    snippet[index].selected = !snippet[index].selected
    @.set('tokenized_snippet', snippet)
    @.trigger('change:tokenized_snippet')

  selectedPositions: ->
    positions = []
    snippet = @.get('tokenized_snippet')
    for token, i in snippet
      positions.push({position: i}) if token.selected
    positions
