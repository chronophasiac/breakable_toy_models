class Coursework < ActiveRecord::Base
  attr_accessible :assignment_id, :completed, :user_id
end
