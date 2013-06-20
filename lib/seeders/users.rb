require 'factory_girl_rails'

module Seeders
  module Users
    class << self
      def seed(options = {})
        User.destroy_all
        users = []
        options[:count] ||= 1
        options[:count].times do
          users << FactoryGirl.create(:user)
        end
        users
      end
    end
  end
end
