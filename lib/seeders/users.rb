module Seeders
  module Users
    class << self
      def seed
        User.destroy_all
        User.create do |user|
          user.email = 'admin@memworks.com'
          user.password =  ENV['MEMWORKS_ADMIN_PASSWORD']
          user.password_confirmation = ENV['MEMWORKS_ADMIN_PASSWORD']
          user.confirmed_at = DateTime.now
          user.role = 'superadmin'
        end
      end
    end
  end
end
