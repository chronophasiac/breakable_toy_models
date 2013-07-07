unless Rails.env.production?
  ENV['MEMWORKS_ADMIN_PASSWORD'] = '123qweasd'
end
