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

require 'spec_helper'

describe Assignment do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:instructions) }
  it { should validate_presence_of(:assignment_type) }
  it { should validate_presence_of(:syllabuses) }

  it { should allow_value("http://google.com").for(:url) }
  it { should_not allow_value("invalid url").for(:url) }

  it { should allow_value("video").for(:assignment_type) }
  it { should allow_value("text").for(:assignment_type) }
  it { should allow_value("audio").for(:assignment_type) }
  it { should_not allow_value("foo").for(:assignment_type) }

  it { should have_many(:card_prerequisites) }
  it { should have_many(:cards) }

  it { should have_many(:courseworks) }
  it { should have_many(:users) }

  it { should have_many(:assignment_ratings) }
  
  it { should have_many(:syllabuses) }
  it { should have_many(:lessons) }

  context 'with valid attributes' do
    let(:assignment) { FactoryGirl.create(:assignment) }

    it 'is valid' do
      expect(assignment).to be_valid
    end
  end
end
