tags = [
  { id: 2, name: '古典雅致'},
  { id: 3, name: '温馨可爱'},
  { id: 4, name: '时尚简约'},
  { id: 5, name: '潮流酷炫'},
  { id: 8, name: '节日庆典'},
  { id: 11, name: '政务专属'},
  { id: 12, name: '新模板'},
]

tags.each{|attrs|
  WebsiteTag.find_or_create_by!( attrs )
}
