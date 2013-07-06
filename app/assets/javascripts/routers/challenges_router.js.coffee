class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    'lessons/:lesson_id/challenges/:challenge_id': 'show'

  show: (lesson_id, challenge_id) =>
    @cards = new Memworks.Collections.Cards({challenge_id: challenge_id, lesson_id: lesson_id})
    @completion = new Memworks.Models.ChallengeCompletion({challenge_id: challenge_id})
    @cards.fetch({
      success: =>
        view = new Memworks.Views.CardsShow(collection: @cards, model: @completion)
        $('.card-container').html(view.render().el)
        $('#string-response').focus()
      })
