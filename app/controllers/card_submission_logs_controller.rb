class CardSubmissionLogsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def create
    card = Card.where(id: params[:card_id]).first
    submission = CardSubmission.update_submission(current_user, card)
    @card_submission_log = submission.card_submission_logs.new(params[:card_submission_log])
    @card_submission_log.correct = card.correct_answer?(params[:answer])

    if @card_submission_log.save
      render json: @card_submission_log, status: :created, root: false
    else
      render json: @card_submission_log.errors, status: :unprocessable_entity, root: false
    end
  end

end
