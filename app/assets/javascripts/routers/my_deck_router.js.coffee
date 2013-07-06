class Memworks.Routers.MyDeck extends Backbone.Router

  routes:
    'users/:user_id/my_deck': 'show'

  show: (user_id) =>
    @cards = new Memworks.Collections.Cards({user_id: user_id})
    @cards.fetch({
      success: =>
        if @cards.length == 0
          view = new Memworks.Views.CardsError()
        else
          view = new Memworks.Views.CardsShow(collection: @cards)
        $('.card-container').html(view.render().el)
        $('#string-response').focus()
      })
