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
