# == Schema Information
#
# Table name: cards
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  instructions  :text             not null
#  problem       :text             not null
#  solution_type :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Card < ActiveRecord::Base
  has_many  :solution_positions,
            inverse_of: :card,
            dependent: :destroy
  has_many  :solution_strings,
            inverse_of: :card,
            dependent: :destroy
  has_many  :card_submissions,
            inverse_of: :card
  has_many  :users,
            through: :card_submissions,
            inverse_of: :cards
  has_many  :card_prerequisites,
            inverse_of: :card,
            dependent: :destroy
  has_many  :assignments,
            through: :card_prerequisites,
            inverse_of: :cards
  has_many  :challenge_decks,
            inverse_of: :card
  has_many  :challenges,
            through: :challenge_decks,
            inverse_of: :cards

  validates_presence_of :title, :instructions, :problem, :assignments, :solution_type

  SOLUTION_TYPES = %w[position string]

  validates_inclusion_of :solution_type, :in => SOLUTION_TYPES

  attr_accessible :instructions, :problem, :solution_type, :title
end
