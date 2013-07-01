class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    'lessons/:lessonID/challenges/:challengeID': 'show'

  initialize: =>
    @collection = new Memworks.Collections.Cards()

  show: (challengeID) =>
    @collection.challengeID = challengeID
    @collection.fetch({
      success: =>
        view = new Memworks.Views.CardsShow(collection: @collection)
        $('.card-container').html(view.render().el)
      })
