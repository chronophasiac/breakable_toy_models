class Memworks.Collections.Challenges extends Backbone.Collection

  initialize: (models, options={}) ->
    @lessonID = options.lessonID || null

  model: Memworks.Models.Challenge

  url: ->
   "/lessons/#{@lessonID}/challenges"
