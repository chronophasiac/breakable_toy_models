class MyDecksController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @my_deck = MyDeck.new(current_user)
  end
end
