# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ActivityType::ENUM_ID_OPTIONS.each{| atts |
  ActivityType.find_or_create_by!( name: atts[0], id: atts [1], description: atts[2] )
}


PaymentType::ENUM_ID_OPTIONS.each{| atts |
  PaymentType.find_or_create_by!( name: atts[0], id: atts [1], description: atts[2] )
}


SiteCopyright.find_or_create_by!( is_default: true) do |copyright|
  copyright.is_show_link = true
  copyright.footer_content = 'this is footer content'
  copyright.footer_link = '<a href="www.baidu.com">footer link</a>'
end

load "#{Rails.root}/db/seed/china_regions/init.rb"
