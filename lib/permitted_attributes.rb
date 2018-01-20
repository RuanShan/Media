module PermittedAttributes
    ATTRIBUTES=[:site_attributes, :account_attributes, :wx_mp_user_attributes, :website_menu_attributes, :material_attributes, :activity_attributes, :shop_attributes,
      :reply_attributes, :wx_menu_attributes, :payment_setting_attributes, :question_attributes, :fight_paper_attributes, :activity_prize_attributes, :vip_recharge_order_attributes, :book_rule_attributes,
      :website_picture_attributes, :website_popup_menu_attributes  ]

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

   # huodong/guesses_controller
   # "activity"=>  {"activity_type_id"=>"75",   "keyword"=>"美图猜猜",   "name"=>"美图猜猜",   "pic_key"=>"",   "summary"=>"",   "description"=>"this is description",  "start_at"=>"2018-01-05",   "end_at"=>"2018-01-06 23:59:59",
   #  "guess_setting_attributes"=>{"user_day_answer_limit"=>"1", "user_total_answer_limit"=>"5", "user_type"=>"1"}}

   # biz/waves_controller
   # "activity"=>{"keyword"=>"", "name"=>"摇一摇抽奖", "pic_key"=>"", "summary"=>"请点击进入摇一摇抽奖页面", "description"=>"摇一摇抽奖说明", "start_at"=>"2018-01-06 00:00", "end_at"=>"2018-01-07 23:59", "bg_pic_key"=>""},

   #一战到底
   # activity"=>
   # { "active_activity_notice_attributes"=>{"title"=>"活动名称", "pic_key"=>"FknTGEgpxbPd-N0LhujFkAbVObEZ", "summary"=>"亲，请点击进入一战到底答题页面，快来参加活动吧！"},
   #  "activity_property_attributes"=>{"activity_type_id"=>"8", "vip_only"=>"0", "special_warn"=>"", "question_score"=>"10"},
   #  "activity_prizes_attributes"=>
   #  {"0"=>{"title"=>"一等奖", "prize"=>"prize1", "prize_count"=>"1"}, "1"=>{"title"=>"二等奖", "prize"=>"prize2", "prize_count"=>"2"}, "2"=>{"title"=>"三等奖", "prize"=>"prize3", "prize_count"=>"3"}}}
   #微官网
   #"activity"=>{"status"=>"1", "keyword"=>"微官网", "name"=>"微官网", "pic_key"=>"FklFClReNPoViyL4EI1C_zqkjD4c", "summary"=>""
   #  "website_attributes"=>{"name"=>"getstore", "logo_key"=>"", , "baidu_app_js"=>"", "analytic_scripts"=>"", "id"=>"1"
   #    "website_setting_attributes"=>{"open_bg_music"=>"0", "open_begin_animation"=>"0", "begin_animation_type"=>"1", "first_display"=>"0", "open_bg_animation"=>"0", "bg_animation_type"=>"1", "analytic_script"=>"", "id"=>"1"}
   #  }
   #}

   @@activity_attributes = [:status, :keyword, :pic_key,
     :activity_type_id, :name, :summary, :description, :start_at, :end_at,
     :bg_pic_key,

     vip_card_attributes: [:status, :merchant_name, :id],
     ready_activity_notice_attributes: [:title, :summary, :id],
     active_activity_notice_attributes: [:title, :summary, :id, :pic_key ],

     guess_setting_attributes: [:user_day_answer_limit, :user_total_answer_limit, :user_type],
     activity_property_attributes: [ :activity_type_id, :vip_only, :special_warn, :question_score ],

     activity_prizes_attributes:[:title, :prize, :prize_count],

     website_attributes:[ :name, :logo_key, :baidu_app_js, :analytic_scripts, :id, website_setting_attributes:[ :open_bg_music, :open_begin_animation, :begin_animation_type, :first_display, :open_bg_animation, :bg_animation_type, :analytic_script, :id] ]
   ]

   @book_rule_attributes = [ :is_limit_money, :type, :rule_type, :shop_branch_id, :book_phone, :booked_minute, :cancel_rule, :created_minute, :description,
     :is_in_branch, :is_in_normal, :is_in_queue, :is_pay_cash, :is_pay_online, :is_send_captcha, :min_money, :preview_day, :book_time_ranges_attributes,
     :is_limit_day, :is_limit_time, :is_open_hall, :is_open_loge, :hall_limit_money, :loge_limit_money, :is_pay_balance, :delivery_time ]


   @@shop_attributes = []

   # "reply"=>{"event_type"=>"text_event", "reply_type"=>"1", "content"=>"auto reply text", "activity_id"=>"1"}
   @@reply_attributes = [:event_type, :reply_type, :content, :activity_id]

   # "wx_menu"=>{"parent_id"=>"0", "key"=>"2_1", "event_type"=>"click", "sort"=>"1", "name"=>"item1", "menu_type"=>"1", "content"=>"默认文本", "material_id"=>"", "activity_id"=>"1", "url"=>""}
   @@wx_menu_attributes = [:parent_id, :key, :event_type, :sort, :name, :menu_type, :content, :material_id, :activity_id, :url ]


   @@payment_setting_attributes = [ :payment_type_id, :partner_id, :partner_key, :partner_account, :app_id, :sort ]

   # GuessQuestionsController
   # "guess_question"=>{"title"=>"what is you name?", "pic_key"=>"FoX7f3MFLta6cYDeYChton_Jy4ZD", "answer_a"=>"1", "answer_b"=>"2", "answer_c"=>"3", "answer_d"=>"", "correct_answer"=>"A"},
   @@question_attributes = [ :id, :title, :pic_key, :answer_a, :answer_b, :answer_c, :answer_d, :answer_e, :correct_answer]

   @@fight_paper_attributes = [:description, :read_time, :fight_question_ids]

   # activity_prize"=>{"activity_id"=>"21", "title"=>"一等奖", "prize_type"=>"normal_prize", "prize"=>"prize1", "points"=>"", "prize_value"=>"", "prize_count"=>"1"}
   @@activity_prize_attributes = [:activity_id, :title, :prize, :prize_count, :points, :prize_value, :prize_count]

   # "vip_recharge_order"=>{"amount"=>"100", "pay_amount"=>"100.0", "given_points"=>"0", "pay_type"=>"10001"}
   @@vip_recharge_order_attributes = [:amount, :pay_amount, :given_points, :pay_type]

   # website_picture"=>
   #{"id"=>"",   "website_id"=>"1",   "title"=>"this is slide",   "pic_key"=>"FgX61VqF669oIDRFtpGNlgB8u18P",   "menu_type"=>"13",   "url"=>"",   "tel"=>"",
   # "address"=>"全国",   "location_x"=>"116.413384",   "location_y"=>"39.910925",   "single_material_id"=>"",   "multiple_material_id"=>"",   "activity_id"=>"1",
   # "docking_type"=>"1",   "docking_function"=>"1",   "goods_category_id"=>"",   "good_id"=>""},
   @@website_picture_attributes = [
     :id, :website_id, :title, :pic_key, :menu_type, :url,:tel, :address,   :location_x,   :location_y,   :single_material_id,   :multiple_material_id,   :activity_id,
     :docking_type,  :docking_function,  :goods_category_id,  :good_id
   ]

  # "website_popup_menu"=>
  # {"website_id"=>"1",   "nav_type"=>"1",   "name"=>"item1",   "font_icon"=>"fa fa-bell",   "icon_key"=>"",   "menu_type"=>"2",   "activity_id"=>"1",   "url"=>"",
  #  "tel"=>"",   "address"=>"全国",   "location_x"=>"116.413384",   "location_y"=>"39.910925",   "single_material_id"=>"",   "multiple_material_id"=>"",   "sort"=>"1"},
  @@website_popup_menu_attributes = [
    :id, :website_id, :nav_type, :name,  :font_icon, :icon_key, :menu_type, :activity_id,  :url,
    :tel, :address, :location_x, :location_y,  :single_material_id,   :multiple_material_id, :sort
  ]

end
