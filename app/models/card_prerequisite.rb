class CardPrerequisite < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :card_prerequisites
  belongs_to  :assignment,
              inverse_of: :card_prerequisites

  validates_presence_of :card, :assignment

  attr_accessible :assignment_id
end
