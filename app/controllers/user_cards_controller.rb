class UserCardsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    my_deck = MyDeck.new(current_user)
    respond_with my_deck.cards, root: false
  end
end
