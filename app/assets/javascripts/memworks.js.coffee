window.Memworks =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    new Memworks.Routers.Challenges()
    new Memworks.Routers.MyDeck()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Memworks.initialize()
