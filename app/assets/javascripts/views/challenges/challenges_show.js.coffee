class Memworks.Views.ChallengesIndex extends Backbone.View

  template: Handlebars.compile['challenges/show']

  render: ->
    $(@el).html(template)

  initialize: ->
    alert("Blah!")
