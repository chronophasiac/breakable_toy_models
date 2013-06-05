# == Schema Information
#
# Table name: assignments
#
#  id              :integer          not null, primary key
#  title           :string(255)      not null
#  instructions    :text             not null
#  url             :string(255)
#  assignment_type :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Assignment < ActiveRecord::Base
  attr_accessible :assignment_type, :instructions, :title, :url

  ASSIGNMENT_TYPE = %w[text audio video]

  validates_presence_of :title 
  validates_presence_of :instructions 
  validates_presence_of :assignment_type 
  validates_presence_of :syllabuses

  validates :url, :url => { allow_blank: true }

  validates_inclusion_of :assignment_type, :in => ASSIGNMENT_TYPE

  has_many  :card_prerequisites,
            inverse_of: :assignment,
            dependent: :destroy

  has_many  :cards,
            through: :card_prerequisites,
            inverse_of: :assignments

  has_many  :courseworks,
            inverse_of: :assignment

  has_many  :users,
            through: :courseworks,
            inverse_of: :assignments

  has_many  :assignment_ratings,
            inverse_of: :assignment

  has_many  :syllabuses,
            inverse_of: :assignment

  has_many  :lessons,
            through: :syllabuses,
            inverse_of: :assignments
end
