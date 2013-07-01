class Memworks.Models.Challenge extends Backbone.Model

  initialize: (model, options={}) ->
    @lessonID = options.lessonID || null
    @challengeID = options.challengeID || null

  url: ->
   "/lessons/#{@lessonID}/challenges/#{@challengeID}"
