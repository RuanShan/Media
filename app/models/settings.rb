class Settings < Settingslogic
  puts "#{Rails.root}/config/services.yml, #{Rails.env}"
  source "#{Rails.root}/config/services.yml"
  namespace Rails.env
end
