class CardSubmissionLog < ActiveRecord::Base
  attr_accessible :answer_correct, :card_submission_id, :rated_difficulty, :time_taken

  validates_presence_of :card_submission_id
  validates_presence_of :answer_correct
  validates_presence_of :time_taken
  validates_presence_of :card_submission

  belongs_to  :card_submission,
              inverse_of: :card_submission_logs
end
