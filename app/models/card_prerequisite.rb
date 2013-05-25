class CardPrerequisite < ActiveRecord::Base
  attr_accessible :assignment_id, :card_id

  validates_presence_of :card_id
  validates_presence_of :assignment_id
  validates_presence_of :card
  validates_presence_of :assignment

  belongs_to  :card,
              inverse_of: :card_prerequisites

  belongs_to  :assignment,
              inverse_of: :card_prerequisites
end
