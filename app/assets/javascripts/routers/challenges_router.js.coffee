class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    'lessons/:lessonID/challenges/:challengeID': 'show'

  initialize: =>
    @cards = new Memworks.Collections.Cards()

  show: (challengeID) =>
    @cards.challengeID = challengeID
    @cards.fetch({
      success: =>
        view = new Memworks.Views.CardsShow(collection: @cards)
        $('.card-container').html(view.render().el)
      })
