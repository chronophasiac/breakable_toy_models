class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    'lessons/:lessonID/challenges/:challengeID': 'show'

  initialize: =>
    @model = new Memworks.Models.Challenge()

  show: (lessonID, challengeID) =>
    @model.lessonID = lessonID
    @model.challengeID = challengeID
    @model.fetch()
    view = new Memworks.Views.ChallengesShow(model: @model)
    $('.card-container').html(view.render().el)
