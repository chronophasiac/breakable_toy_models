# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  lesson_id        :integer          not null
#  last_accessed_at :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Enrollment do
  it { should belong_to(:user) }
  it { should belong_to(:lesson) }

  it { should validate_presence_of(:last_accessed_at) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:lesson) }

  it { should allow_value(DateTime.now).for(:last_accessed_at) }
  it { should_not allow_value(DateTime.now + 1.minute).for(:last_accessed_at) }

  context "with two enrollments" do

    let!(:user)        { FactoryGirl.create(:user) }
    let!(:lesson)      { FactoryGirl.create(:lesson) }
    let!(:enrollment)  { FactoryGirl.create(:enrollment, user: user, lesson: lesson) }

    it "is valid with different users on the same lesson" do
      other_enrollment = FactoryGirl.build(:enrollment, lesson: lesson)
      expect(other_enrollment).to be_valid
    end

    it "is valid with the same user on different lessons" do
      other_enrollment = FactoryGirl.build(:enrollment, user: user)
      expect(other_enrollment).to be_valid
    end

    it "is not valid with the same user and the same lesson" do
      other_enrollment = FactoryGirl.build(:enrollment, user: user, lesson: lesson)
      expect(other_enrollment).to_not be_valid
    end

  end

end
