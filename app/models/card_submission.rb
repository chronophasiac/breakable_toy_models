class CardSubmission < ActiveRecord::Base
  attr_accessible :card_id, :helpful, :user_id

  belongs_to  :card,
              inverse_of: :card_submission

  belongs_to  :user,
              inverse_of: :card_submission
end
