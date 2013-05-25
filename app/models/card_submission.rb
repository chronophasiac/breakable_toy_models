class CardSubmission < ActiveRecord::Base
  attr_accessible :card_id, :helpful, :user_id

  validates_presence_of :card_id
  validates_presence_of :user_id

  belongs_to  :card,
              inverse_of: :card_submission

  belongs_to  :user,
              inverse_of: :card_submission
end
