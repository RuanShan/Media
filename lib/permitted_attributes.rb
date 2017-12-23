module PermittedAttributes
    ATTRIBUTES=[:site_attributes, :wx_mp_user_attributes]
    mattr_reader *ATTRIBUTES

    @@site_attributes = [ :section_id,:title, :content_param, :data_source, :data_filter, :data_source_order_by, :data_source_param, :css_class, :css_class_for_js, :content_css_class, :stylish, :section_context ]
    @@wx_mp_user_attributes = [:nickname, :openid, :user_type, :app_id, :app_secret, :encoding_aes_key]

end
