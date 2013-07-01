window.Memworks =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    new Memworks.Routers.Challenges()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Memworks.initialize()
