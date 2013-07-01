# == Schema Information
#
# Table name: solution_strings
#
#  id         :integer          not null, primary key
#  regex      :string(255)      not null
#  card_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SolutionString < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :solution_strings

  validates_presence_of :regex, :card

  attr_accessible :card_id, :regex

  def correct_response?(response)
    !response.downcase.match(regex).nil?
  end
end
