class Memworks.Routers.MyDeck extends Backbone.Router

  routes:
    'users/:user_id/my_deck': 'show'

  show: (user_id) =>
    @cards = new Memworks.Collections.Cards({user_id: user_id})
    @cards.fetch({
      success: =>
        view = new Memworks.Views.ChallengesShow(collection: @cards)
        $('.card-container').html(view.render().el)
        $('#string-response').focus()
      })
