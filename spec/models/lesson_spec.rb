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
    let(:lesson) { FactoryGirl.create(:lesson) }

    it 'is valid' do
      expect(lesson).to be_valid
    end
  end
end
