# == Schema Information
#
# Table name: solution_strings
#
#  id         :integer          not null, primary key
#  regex      :string(255)      not null
#  card_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe SolutionString do
  it { should validate_presence_of(:regex) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:card) }
end
