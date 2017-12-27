class Province < ActiveRecord::Base
  DefaultID = 310000 #上海市

  has_many :cities
end
