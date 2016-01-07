class Mobile::MicroStoresController < Mobile::BaseController
  skip_before_filter :auth, :authorize, except: [:map]
  before_filter :update_wx_user_location
  layout "mobile/micro_stores"

  def index
    return render_404 unless @supplier
    @search = @supplier.shop_branches.used.search(params[:search])
    @shop_branches = Kaminari.paginate_array(ShopBranch.some_shop_branches(@supplier,@wx_user)).page(params[:page]) if params[:msg_type] == "location"
    @shop_branches ||= if (session[:wx_user_id].present? && @wx_user.location_updated_at.present? && @wx_user.location_updated_at + 10.minutes > Time.now)
      Kaminari.paginate_array(ShopBranch.search_some_shop_branches(@search,@wx_user)).page(params[:page])
    else
      @search.order(:id).page(params[:page])
    end
  end
  
  def show
    @shop_branch = ShopBranch.find(params[:id])
    @href = {
      "dinner" => book_dinner_app_shops_path,
      "out"    => take_out_app_shops_path,
      "table"  => app_shops_path
    }[params[:ref]] || mobile_micro_stores_path
    params = { address: @shop_branch.ditu_address, output: 'json', ak: '9c72e3ee80443243eb9d61bebeed1735' }
    result = RestClient.get("http://api.map.baidu.com/geocoder/v2/", params: params)
    data = JSON(result)
    @location = data['result']['location'] 
  rescue 
    @location = {}
  end

  def map
    return render text: '参数不正确' unless @supplier && @wx_user
    @shop_branches = ShopBranch.some_shop_branches(@supplier,@wx_user)
    return render_404 if @shop_branches.blank?
    render 'index_map'
  end

  def list
    return render text: '参数不正确' unless session[:wx_mp_user_id]    
    @search = ShopBranch.used.where(wx_mp_user_id: session[:wx_mp_user_id]).search(params[:search])
    @shop_branches = @search.order(:id)
    render 'index'
  end

  private
    def nearest_shop_branch( shop_branches, wx_user )
      return shop_branches.first unless wx_user
      return shop_branches.first if wx_user.location_x.blank? || wx_user.location_y.blank?
      shop_branches.sort_by! do |sb|
        if sb.location_x.blank? && sb.location_y.blank?
          360 ** 2 * 2
        else
          (sb.location_x.to_f - wx_user.location_x.to_f) ** 2 + (sb.location_y.to_f - wx_user.location_y.to_f) ** 2
        end
      end
    end

    def update_wx_user_location
      @wx_user = WxUser.where(id: session[:wx_user_id]).first
      # if @wx_user.try(:location_x).blank?
      #   result = RestClient.get("http://api.map.baidu.com/location/ip?ip=#{request.ip}&ak=9c72e3ee80443243eb9d61bebeed1735&coor=bd09ll")
      #   info = JSON(result)
      #   @wx_user = OpenStruct.new(location_x: info["content"]["point"]["y"], location_y: info["content"]["point"]["x"], location_updated_at: Time.now)
      # end
    end
  
end
