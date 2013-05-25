class CardSubmissionLog < ActiveRecord::Base
  attr_accessible :answer_correct, :card_submission_id, :rated_difficulty, :time_taken
end
