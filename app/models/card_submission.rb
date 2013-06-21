# == Schema Information
#
# Table name: card_submissions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  card_id    :integer          not null
#  helpful    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CardSubmission < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :card_submissions
  belongs_to  :user,
              inverse_of: :card_submissions
  has_many    :card_submission_logs,
              inverse_of: :card_submission,
              dependent: :destroy

  validates_presence_of :user, :card

  attr_accessible :card_id, :helpful
end
