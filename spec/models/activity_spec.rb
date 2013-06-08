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

require 'spec_helper'

describe Activity do
  it { should validate_presence_of(:position) }
  it { should validate_presence_of(:lesson) }
  it { should validate_presence_of(:completable) }
  it { should validate_presence_of(:completable_type) }

  it { should belong_to(:lesson) }
  it { should belong_to(:completable) }

  it { should allow_value(0).for(:position) }
  it { should allow_value(1).for(:position) }
  it { should_not allow_value(-1).for(:position) }
end
