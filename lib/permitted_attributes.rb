module PermittedAttributes
    ATTRIBUTES=[:site_attributes, :account_attributes, :wx_mp_user_attributes, :website_menu_attributes, :material_attributes, :activity_attributes, :shop_attributes,
      :reply_attributes, :wx_menu_attributes, :payment_setting_attributes]
    mattr_reader *ATTRIBUTES

    @@site_attributes = [ :section_id,:title, :content_param, :data_source, :data_filter, :data_source_order_by, :data_source_param, :css_class, :css_class_for_js, :content_css_class, :stylish, :section_context ]
    @@account_attributes = [:nickname, :password, :password_confirmation, :company_name, :account_category_id, :province_id, :city_id, :district_id, :address, :contact, :mobile, :email ]
    @@wx_mp_user_attributes = [:nickname, :openid, :user_type, :app_id, :app_secret, :encoding_aes_key]
    #
    #"website_id"=>"1", "old_parent_id"=>"0", "name"=>"test", "summary_type"=>"1", "summary"=>"", "is_delete_pic"=>"", "font_icon"=>"fa fa-building-o", "pic_key"=>"", "is_delete_cover_pic"=>"1", "cover_pic_key"=>"", "parent_id"=>"0", "menu_type"=>"1", "subtitle_type"=>"1", "subtitle"=>"", "content"=>"this is content", "url"=>"", "tel"=>"", "address"=>"大连市", "location_x"=>"121.621631", "location_y"=>"38.918954", "single_material_id"=>"", "multiple_material_id"=>"", "qq"=>"", #"docking_type"=>"1", "docking_function"=>"1", "goods_category_id"=>"", "good_id"=>""
    @@website_menu_attributes = [:website_id, :old_parent_id, :name, :summary_type, :summary, :is_delete_pic, :font_icon, :pic_key, :is_delete_cover_pic, :cover_pic_key, :parent_id, :menu_type, :subtitle_type, :subtitle, :content, :url,
      :tel, :address, :location_x, :location_y, :single_material_id, :multiple_material_id, :qq, :docking_type, :docking_function, :goods_category_id, :good_id ]

    # "material"=>{"material_type"=>"1", "title"=>"test", "author"=>"", "pic_key"=>"FlL1C_QEO1l-6TwumUieLdO8kjKN", "is_show_pic"=>"1", "reply_type"=>"1", "summary"=>"", "content"=>"this is content", "activity_id"=>"1", "source_url"=>""}
    @@material_attributes = [:material_type, :title, :author, :pic_key, :is_show_pic, :reply_type, :summary, :content, :activity_id, :source_url ]



   # "activity"=>{"status"=>"1", "id"=>"2",
   #   "keyword"=>"会员卡", "pic_key"=>"",
   #   "vip_card_attributes"=>{"status"=>"1", "merchant_name"=>"getstore", "id"=>"1"},
   #   "ready_activity_notice_attributes"=>{"title"=>"申请微信会员卡", "summary"=>"您尚未申请会员特权,快来点击申领吧!!", "id"=>"1"},
   #   "active_activity_notice_attributes"=>{"title"=>"尊敬的会员{name}", "summary"=>"尊敬的会员{name},您的会员卡号为{card_id},快来点击查看优惠信息吧!!", }}
   @@activity_attributes = [:status, :keyword, :pic_key,
     vip_card_attributes: [:status, :merchant_name, :id],
     ready_activity_notice_attributes: [:title, :summary, :id],
     active_activity_notice_attributes: [:title, :summary, :id]
   ]

   @@shop_attributes = []

   # "reply"=>{"event_type"=>"text_event", "reply_type"=>"1", "content"=>"auto reply text", "activity_id"=>"1"}
   @@reply_attributes = [:event_type, :reply_type, :content, :activity_id]

   # "wx_menu"=>{"parent_id"=>"0", "key"=>"2_1", "event_type"=>"click", "sort"=>"1", "name"=>"item1", "menu_type"=>"1", "content"=>"默认文本", "material_id"=>"", "activity_id"=>"1", "url"=>""}
   @@wx_menu_attributes = [:parent_id, :key, :event_type, :sort, :name, :menu_type, :content, :material_id, :activity_id, :url ]


   @@payment_setting_attributes = [ :payment_type_id, :partner_id, :partner_key, :partner_account, :app_id, :sort ]

end
