class ChallengesController < ApplicationController
  before_filter :authenticate_user!
  #TODO include in other controllers
  inherit_resources
  actions :show
  respond_to :html, :json

  def show
    show! do |format|
      @lesson = Lesson.where(id: params[:lesson_id]).first
      @challenge_progression = current_user.challenge_progressions.where(challenge_id: @challenge_id).first
      #TODO use resource
      format.json { render json: resource  }
    end
  end

end
