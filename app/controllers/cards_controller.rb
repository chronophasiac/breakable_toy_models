class CardsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    if params[:challenge_id]
      challenge = Challenge.find(params[:challenge_id])
      respond_with challenge.cards.all, root: false
    else
      respond_with Card.all
    end
  end
end
