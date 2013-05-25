class CardSubmission < ActiveRecord::Base
  attr_accessible :card_id, :helpful, :user_id
end
