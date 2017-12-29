Province.destroy_all

provinces_json = JSON.load( File.read(File.expand_path('json/province.json', File.dirname(__FILE__) )))

provinces = provinces_json.map{|json|
  province = Province.create!( json )
}


#{
#    "110000": [
#        {
#            "province": "北京市",
#            "name": "市辖区",
#            "id": "110100"
#        }
#    ]
#}
cities_json = JSON.load( File.read(File.expand_path('json/city.json', File.dirname(__FILE__) )))


cities_json.each_pair{|province_id, province_cities_json|
  province = Province.find( province_id )
  province_cities_json.each{| json|
     City.create!( id: json['id'], name:json['name'], province: province )
  }
}

#{
#    "110100": [
#        {
#            "city": "市辖区",
#            "name": "东城区",
#            "id": "110101"
#        },
#   ]
# }

areas_json = JSON.load( File.read(File.expand_path('json/area.json', File.dirname(__FILE__) )))

areas_json.each_pair{|city_id, city_areas_json|
  city = City.find( city_id )
  city_areas_json.each{| json|
     District.create!( id: json['id'], name:json['name'], city: city )
  }
}
