# == Schema Information
#
# Table name: activities
#
#  id               :integer          not null, primary key
#  lesson_id        :integer          not null
#  completable_id   :integer          not null
#  completable_type :string(255)      not null
#  position         :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Activity < ActiveRecord::Base
  belongs_to  :completable,
              polymorphic: true,
              inverse_of: :activities

  belongs_to  :lesson,
              inverse_of: :activities

  validates_presence_of :completable, :completable_type, :lesson, :position

  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  attr_accessible :completable_id, :completable_type, :lesson_id, :position
end
