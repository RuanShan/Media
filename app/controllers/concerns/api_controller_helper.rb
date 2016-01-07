module ApiControllerHelper

  def weixin_news_item_for_material(material, pic_size: :large)
    pic_url  = material.try(:pic_key).present? ? qiniu_image_url(material.try(:pic_key)) : "#{host}#{material.try(:pic).try(pic_size)}"
    url      = url_for_material(material)
    {title: material.title, description: material.summary, pic_url: pic_url, url: url}
  end

  def url_for_material(material)
    if material.activity?
      respond_activity_link(material.materialable)
    elsif material.link?
      material.source_url
    else
      "#{app_material_url(material, wxmuid: @mp_user.id)}#mp.weixin.qq.com"
    end
  end

  def respond_wmall_activity(from_user_name, to_user_name, qrcodeable)
    url = wmall_shop_url({shop_id: qrcodeable.id, wx_user_open_id: from_user_name, wx_mp_user_open_id: to_user_name, supplier_id: qrcodeable.try(:mall).try(:supplier_id)})
    activity = Activity.where(activity_type_id: 54,activityable_type:"Wmall::Shop", activityable_id: qrcodeable.id).first
    pic_url = (activity && activity.qiniu_pic_key.present?) ? activity.qiniu_pic_url_for_wmall : qrcodeable.pic_url
    items = [{title: qrcodeable.name, description: qrcodeable.description, pic_url: pic_url , url: url}]
    @echostr = Weixin.respond_news(from_user_name, to_user_name, items)
  end

  def respond_wmall_ec_good(from_user_name, to_user_name, qrcodeable)
    url = wmall_ec_good_url({ec_good_id: qrcodeable.id, wx_user_open_id: from_user_name, wx_mp_user_open_id: to_user_name, supplier_id: qrcodeable.try(:mall).try(:supplier_id)})
    pic_url = Wmall::EcGoodPicture.where(goods_id: qrcodeable.id, status: 1).first.qiniu_pic_url
    items = [{title: qrcodeable.name, description: "", pic_url: pic_url, url: url}]
    @echostr = Weixin.respond_news(from_user_name, to_user_name, items)
  end

  def respond_wmall_ec_coupon(from_user_name, to_user_name, qrcodeable)
    url = detail_wmall_coupon_url({coupon_id: qrcodeable.id, wx_user_open_id: from_user_name, wx_mp_user_open_id: to_user_name, supplier_id: qrcodeable.try(:shop).try(:mall).try(:supplier_id)})
    pic_url = qrcodeable.pictures.first.qiniu_pic_url
    items = [{title: qrcodeable.name, description: "", pic_url: pic_url, url: url}]
    @echostr = Weixin.respond_news(from_user_name, to_user_name, items)
  end

  def respond_wmall_ec_group_good(from_user_name, to_user_name, qrcodeable)
    url = detail_wmall_group_url({group_id: qrcodeable.id, wx_user_open_id: from_user_name, wx_mp_user_open_id: to_user_name, supplier_id: qrcodeable.try(:shop).try(:mall).try(:supplier_id)})
    pic_url = Wmall::GroupPicture.where(goods_id: qrcodeable.id).first.qiniu_pic_url
    items = [{title: qrcodeable.group_name, description: "", pic_url: pic_url, url: url}]
    @echostr = Weixin.respond_news(from_user_name, to_user_name, items)
  end

end