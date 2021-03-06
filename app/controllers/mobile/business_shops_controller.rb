class Mobile::BusinessShopsController < Mobile::BaseController
  before_action :find_website, :find_business_shop, :find_vip_user
  layout "mobile/business_shops"

  def show
    return if @template_id == 1
    @vip_card_branch = @business_shop.vip_card_branch
    @vip_card = @vip_card_branch.vip_card
    return redirect_to mobile_notice_url(msg: '会员卡不存在') unless @vip_card
    @vip_user = @site.vip_users.where(user_id: session[:user_id]).first
    @privileges = @business_shop.business_privileges
    @vip_card_pic = @vip_card_branch.pic_url || 'http://img-asset.winwemedia.com/FudiRXyXaCchVosPYrv22Ws9do1F'
    render "template_#{@template_id}"
  end

  def privileges
    @vip_card_branch = @business_shop.vip_card_branch
    @vip_card = @vip_card_branch.vip_card
    @privileges = @business_shop.business_privileges

    @vip_card_pic = @vip_card_branch.pic_url || 'http://img-asset.winwemedia.com/FudiRXyXaCchVosPYrv22Ws9do1F'
  rescue
    return render text: '请求页面不存在'
  end
  
  def items
    @items = @business_shop.business_items
  rescue
    return render text: '请求页面不存在'
  end

  def item
    @item = @business_shop.business_items.find params[:item_id]
  rescue
    return render text: '请求页面不存在'
  end
  
  def pictures
    @pictures_arr = @business_shop.business_shop_pictures.recent
    slice_length = @pictures_arr.count / 2 + @pictures_arr.count.modulo(2)
    @pictures_arr = @pictures_arr.each_slice(slice_length).to_a if slice_length > 0
  rescue
    return render text: '请求页面不存在'
  end
  
  def flashshow
    @pictures = @business_shop.business_shop_pictures.recent
  rescue
    return render text: '请求页面不存在'
  end
  
  def comments
    @comments = @business_shop.comments.latest.page(params[:page])
    @comment = Comment.new if @template_id == 1
    respond_to do |format|
      format.html
      format.js
    end
  rescue
    return render text: '请求页面不存在'
  end

  def leave_comment
    @comment = Comment.new
    @comment.build_business_shop_impression
  rescue
    return render text: '请求页面不存在'
  end

  def create_comment
    @comment = @business_shop.comments.new(params[:comment].merge(commenter_id: session[:user_id], commenter_type: 'User', site_id: @site.id))
    if Comment.already_today?(session[:user_id], @business_shop.id)
      redirect_to :back, alert: "您今天已经发表过评论了！"
    elsif @comment.save
      redirect_to comments_mobile_business_shop_url(@site,@business_shop), notice: "评价成功！"
    else
      redirect_to :back, alert: "评价失败，#{@comment.errors.full_messages.first}"
    end
  end

  private
    def find_website
      @website = @site.circle
    end

    def find_business_shop
      @business_shop = @website.business_shops.normal.find params[:id]
      @template_id = ( @business_shop.template_id || @website.template_id ).to_i
    end

    def find_vip_user
      @vip_user = VipUser.where(user_id: session[:user_id]).first
    end
end
