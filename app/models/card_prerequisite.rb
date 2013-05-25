class CardPrerequisite < ActiveRecord::Base
  attr_accessible :assignment_id, :card_id

  belongs_to  :card,
              inverse_of: :card_prerequisite

  belongs_to  :assignment,
              inverse_of: :card_prerequisite
end
