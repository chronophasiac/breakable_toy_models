class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    'lessons/:lessonID/challenges/:challengeID': 'show'

  initialize: =>
    @cards = new Memworks.Collections.Cards()

  show: (lessonID, challengeID) =>
    @completion = new Memworks.Models.ChallengeCompletion({challenge_id: challengeID})
    @cards.challengeID = challengeID
    @cards.lessonID = lessonID
    @cards.fetch({
      success: =>
        view = new Memworks.Views.ChallengesShow(collection: @cards, model: @completion)
        $('.card-container').html(view.render().el)
        $('#string-response').focus()
      })
