class ChallengeProgressionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def create
    @challenge_progression = current_user.challenge_progressions.new(params[:challenge_progression])

    if @challenge_progression.save
      render json: @challenge_progression, status: :created, root: false
    else
      render json: @challenge_progression.errors, status: :unprocessable_entity, root: false
    end
  end

end
