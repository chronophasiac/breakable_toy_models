class Memworks.Models.Position extends Backbone.Model

class Memworks.Collections.Positions extends Backbone.Collection

class Memworks.Models.Card extends Backbone.Model

  initialize: ->
    @positions = new Memworks.Collections.Positions()
