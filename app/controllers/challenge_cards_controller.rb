class ChallengeCardsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    challenge = Challenge.find(params[:challenge_id])
    respond_with challenge.cards.all, root: false
  end
end
