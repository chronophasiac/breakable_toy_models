class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    'lessons/:lessonID/challenges/:challengeID': 'show'

  initialize: =>
    @cards = new Memworks.Collections.Cards()

  show: (lessonID, challengeID) =>
    @progression = new Memworks.Models.ChallengeProgression({challenge_id: challengeID})
    @cards.challengeID = challengeID
    @cards.lessonID = lessonID
    @cards.fetch({
      success: =>
        view = new Memworks.Views.ChallengesShow(collection: @cards, model: @progression)
        $('.card-container').html(view.render().el)
      })
