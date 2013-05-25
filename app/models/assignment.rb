class Assignment < ActiveRecord::Base
  attr_accessible :assignment_type, :instructions, :title, :url
end
