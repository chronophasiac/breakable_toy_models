class Card < ActiveRecord::Base
  attr_accessible :instructions, :problem, :title
end
