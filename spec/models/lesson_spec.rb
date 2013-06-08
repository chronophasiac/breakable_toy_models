# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  summary    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Lesson do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:summary) }

  it { should have_many(:syllabuses) }
  it { should have_many(:assignments) }

  it { should have_many(:enrollments) }
  it { should have_many(:users) }

  it { should have_many(:challenges) }

  context 'with valid attributes' do
    let!(:lesson)       { FactoryGirl.create(:lesson) }
    let!(:challenge)    { FactoryGirl.create(:challenge, lesson: lesson, position: 3) }
    let!(:assignment2)  { FactoryGirl.build(:assignment) }
    let!(:assignment)   { FactoryGirl.build(:assignment) }

    before(:each) do
      s1 = FactoryGirl.build(:syllabus, lesson: lesson, assignment: assignment2, position: 2)
      s1.save!
      s2 = FactoryGirl.build(:syllabus, lesson: lesson, assignment: assignment, position: 1)
      s2.save!
    end

    it 'is valid' do
      expect(lesson).to be_valid
    end

    it "has a curriculum" do
      expect(lesson.curriculum).to be_a(Array)
    end

    it "has a curriculum with curriculum items" do
      expect(lesson.curriculum).to include(assignment)
      expect(lesson.curriculum).to include(assignment2)
      expect(lesson.curriculum).to include(challenge)
    end

    it "has a curriculum sorted by position" do
      expect(lesson.curriculum.first).to eql(assignment)
    end
  end

end
