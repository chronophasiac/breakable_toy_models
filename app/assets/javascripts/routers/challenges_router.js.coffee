class Memworks.Routers.Challenges extends Backbone.Router

  routes:
    "lessons/:id/challenges/:id":     "show"

  show: ->
    alert("foo")
