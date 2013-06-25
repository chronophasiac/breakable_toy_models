class ChallengesController < ApplicationController
  inherit_resources
  actions :show

  def show
    show! do
      if user_signed_in?
        @lesson = Lesson.where(id: params[:lesson_id]).first
        @challenge_progression = current_user.challenge_progressions.where(challenge_id: @challenge_id).first
      end
    end
  end

end
