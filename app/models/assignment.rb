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
  has_many  :activities,
            as: :completable,
            dependent: :destroy
  has_many  :lessons,
            through: :activities,
            inverse_of: :assignments

  validates_presence_of :title, :instructions, :assignment_type 

  validates :url, :url => { allow_blank: true }

  ASSIGNMENT_TYPE = %w[text audio video]

  validates_inclusion_of :assignment_type, :in => ASSIGNMENT_TYPE

  attr_accessible :assignment_type, :instructions, :title, :url
end
