class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    'lessons/:lessonID/challenges/:challengeID': 'show'

  initialize: =>
    @collection = new Memworks.Collections.Cards()

  show: (challengeID) =>
    @collection.challengeID = challengeID
    @collection.fetch()
    view = new Memworks.Views.ChallengesShow(collection: @collection)
    $('.card-container').html(view.render().el)
