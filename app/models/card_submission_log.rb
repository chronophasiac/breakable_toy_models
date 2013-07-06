class CardSubmissionLog < ActiveRecord::Base
  belongs_to  :card_submission,
              inverse_of: :card_submission_logs
  has_one     :user,
              through: :card_submission,
              inverse_of: :card_submission_logs,
              readonly: true
  has_one     :card,
              through: :card_submission,
              inverse_of: :card_submission_logs,
              readonly: true

  validates_presence_of :time_taken, :card_submission

  validates :rated_difficulty, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 6 }, allow_blank: true

  validates :time_taken, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  attr_accessible :correct, :rated_difficulty, :time_taken
end
