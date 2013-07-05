class ChallengeCompletionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def create
    @challenge_completion = current_user.challenge_completions.new(params[:challenge_completion])

    if @challenge_completion.save
      render json: @challenge_completion, status: :created, root: false
    else
      render json: @challenge_completion.errors, status: :unprocessable_entity, root: false
    end
  end

end
