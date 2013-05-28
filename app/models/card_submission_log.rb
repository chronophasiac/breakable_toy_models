class CardSubmissionLog < ActiveRecord::Base
  attr_accessible :answer_correct, :card_submission_id, :rated_difficulty, :time_taken

  validates_presence_of :answer_correct
  validates_presence_of :time_taken
  validates_presence_of :card_submission

  validates :rated_difficulty, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 6 }, allow_blank: true

  validates :time_taken, numericality: { only_integer: true, greater_than: 0 }

  belongs_to  :card_submission,
              inverse_of: :card_submission_logs
end
