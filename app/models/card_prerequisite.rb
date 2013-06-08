# == Schema Information
#
# Table name: card_prerequisites
#
#  id            :integer          not null, primary key
#  card_id       :integer          not null
#  assignment_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CardPrerequisite < ActiveRecord::Base
  attr_accessible :assignment_id, :card_id

  validates_presence_of :card
  validates_presence_of :assignment

  belongs_to  :card,
              inverse_of: :card_prerequisites

  belongs_to  :assignment,
              inverse_of: :card_prerequisites
end
