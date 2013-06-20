# == Schema Information
#
# Table name: challenges
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Challenge < ActiveRecord::Base
  has_many  :challenge_progressions,
            inverse_of: :challenge,
            dependent: :destroy
  has_many  :users,
            through: :challenge_progressions,
            inverse_of: :challenges
  has_many  :activities,
            as: :completable,
            dependent: :destroy
  has_many  :lessons,
            through: :activities
  has_many  :challenge_decks,
            inverse_of: :challenge,
            dependent: :destroy
  has_many  :cards,
            through: :challenge_decks,
            inverse_of: :challenges

  validates_presence_of :title
  
  attr_accessible :title
end
