# 1 读心小博士 ,  2 最强眼力,  3. xxx, 4.一个都不能死, 5.密室逃脱
# 6 青蛙过河, 7 2048,  8 辨色, 9 别踩白块, 10 视力测试, 11 吃月饼

attrs = [{ name: '读心小博士', status:1 }, { name: '最强眼力', status:1 }, { name: 'xxx', status: -1}, { name: '一个都不能死', status:1 },
  { name: '密室逃脱', status:1 }, { name: '青蛙过河', status:1 }, { name: '2048', status:1 }, { name: '辨色', status:1 }, { name: '别踩白块', status:1 },
  { name: '视力测试', status:1 }, { name: '吃月饼', status:1 }
]

attrs.each_with_index{| atts, i |
  atts[:sort] = i+1
  FansGame.find_or_create_by!( atts )
}
