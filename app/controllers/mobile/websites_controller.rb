#微官网
class Mobile::WebsitesController < ActionController::Base
  #include ErrorHandler, DetectUserAgent, LikeableCommentable
  include DetectUserAgent, LikeableCommentable

  helper_method :judge_andriod_version, :wx_browser?

  # before_action :redirect_to_non_openid_url, :load_site, :find_website, :load_user_data, except: [:audio, :unknown_identity]
  before_action :redirect_to_non_openid_url, :load_site, :find_website, :load_user_data, except: [:audio]
  skip_before_action :redirect_to_non_openid_url, :find_website, :load_user_data, only: [:unknown_identity]

  before_action :auth, if: -> { @wx_mp_user.try(:manual?) }
  before_action :authorize, if: -> { @wx_mp_user.try(:plugin?) }
  before_action :fetch_wx_user_info

  layout 'mobile/weisiteV01'

  def index
    @website_pictures = @website.website_pictures

    @nav_template_id = @website_setting.index_nav_template_id.to_i
    @nav_menus = @nav_template_id > 0 && @website.home_nav_menus.order(:sort) || []

    if @template_id == 16
      @list_template_id = 8
    elsif [18, 36, 81].include?(@template_id)
      @nav_template_id = 14 if @template_id == 36
      @menu_template_id = 0
    end
    if @site && session[:user_id].to_i > 0
      @current_user_is_fans = @wx_mp_user && @wx_mp_user.has_fans?(session[:user_id])
    end

    @home_template = @website_setting.home_template

    render layout: "mobile/weisiteV0#{@home_template.series.to_i + 1}"
  end

  def channel
    @nav_menus = @nav_template_id > 0 && @website.inside_nav_menus.order(:sort) || []
    if params[:popup_menu_id] || params[:website_picture_id]
      @website_popup_menu = WebsitePopupMenu.find(params[:popup_menu_id].to_i) if params[:popup_menu_id]
      @website_popup_menu = WebsitePicture.find(params[:website_picture_id].to_i) if params[:website_picture_id]

      if @website_popup_menu.try(:single_graphic?)
        @material = @website_popup_menu.menuable
        return render 'detail'
      elsif @website_popup_menu.try(:multiple_graphic?)
        @website_menu = @website_popup_menu
        @main_material = @website_menu.menuable
      elsif @website_popup_menu.games?
        @website_menu = @website_popup_menu
      elsif @website_popup_menu.link?
        redirect_to @website_popup_menu.url
      elsif @website_popup_menu.activity?
        redirect_to website_activity_link(@website_popup_menu)
      end
    else
      @website_menu = WebsiteMenu.find(params[:website_menu_id])
      if @website_menu.has_children? || @website_menu.games?
      elsif @website_menu.multiple_graphic?
        @main_material = @website_menu.menuable
      elsif @website_menu.single_graphic? || @website_menu.text?
        @material = @website_menu.menuable if @website_menu.single_graphic?
        likes_comments_partial(@website_menu, @user)
        return render 'detail'
      elsif @website_menu.url?
        redirect_to @website_menu.url
      # elsif @website_menu.activity?
      #   redirect_to website_activity_link(@website_menu)
      end
    end
    # rescue => e
    #   render text: "页面错误： #{e}"
  end

  def detail
    @nav_menus = @nav_template_id > 0 && @website.inside_nav_menus.order(:sort) || []
    @website_menu = @website.website_menus.where(id: params[:website_menu_id].to_i).first
    @material = Material.where(id: params[:material_id].to_i).first
    @share_image = @material.present? ? @material.pic_url :  @website_menu.try(:pic_key)
    likes_comments_partial(@material, @user)
    return redirect_to four_o_four_url if @website_menu.blank? && @material.blank?
  end

  def audio
    @audio = Material.find(params[:id])
    render layout: false
  end

  def map
    begin
      address = @shortcut_menus.nav.first.try(:address)
      params = { address: address, output: 'json', ak: '9c72e3ee80443243eb9d61bebeed1735'}
      result = RestClient.get("http://api.map.baidu.com/geocoder/v2/", params: params)
      data = JSON(result)
      @location = data['result']['location']
    rescue
      @location = {}
    end

    return render text: '地址没设置或不存在' if @location.blank?

    render layout: false
  end

  def sitemap
    render layout: false
  end

  def unknown_identity
    @wx_mp_user = @site.wx_mp_user
    @activity = Activity.where(id: session[:activity_id].to_i).first
    render layout: false
  end

  private

  def find_website
    @website = @site.website

    return render text: '微官网不存在' unless @website
    return render text: '商家正在升级网站内容，暂停访问' unless @website.active?
    return render text: '该公众号服务已到期，暂不提供服务！' if @site.froze?

    @wx_mp_user = @site.wx_mp_user
    @site_copyright = @site.copyright

    @shortcut_menus =  @website.shortcut_menus.order(:sort)
    @website_menus = @website.website_menus.root.limit_columns.order(:sort)

    # 暂时先处理，上传到生产环境会初始化数据
    @website_setting = @website.website_setting ||= @website.create_default_setting

    @template_id = params[:template_id].try(:to_i) || @website_setting.home_template_id || 1
    @website_setting.home_template_id = @template_id
    @list_template_id = params[:template_id].try(:to_i) || @website_setting.list_template_id || 1
    @detail_template_id = @website_setting.detail_template_id || 1
    @nav_template_id = @website_setting.nav_template_id.to_i
    @menu_template_id = @website_setting.menu_template_id.to_i
  rescue => error
    return render text: "出错了：#{error.message}"
  end

end
