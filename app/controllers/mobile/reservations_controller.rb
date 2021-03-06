class Mobile::ReservationsController < Mobile::BaseController
  layout 'mobile/reservations'

  before_action :block_non_wx_browser
  before_action :find_reservation, :find_order, except: [:send_sms]
  before_action :check_subscribe, except: [:send_sms]

  helper_method :captcha_invalid

  def index
    @orders = @user.try(:reservation_orders).where(activity_id: @activity.id).order('created_at DESC') rescue []
  end

  def detail
    redirect_to mobile_reservations_url unless @order.user_id.to_i == @user.id
  end

  def result
    redirect_to mobile_reservations_url unless @order.user_id.to_i == @user.id
  end

  def abandon
    @order.update_attributes(status: ReservationOrder::ABANDONED)
    redirect_to mobile_reservations_url(activity_id: @activity.id)
  end

  def reserve
    return render json: { ajax_msg: { status: -3 } } if captcha_invalid
    @order = @user.reservation_orders.create(site_id: @activity.site_id, user_id: @user.id, activity_id: @activity.id)
    if @order.persisted?
      params[:custom_field].to_a.each do |key, value|
        field = CustomField.find(key)
        field.custom_values.create(customized_type: 'ReservationOrder', customized_id: @order.id, value: value)
      end
      render json: { ajax_msg: { status: 1, url: result_mobile_reservation_url(id: @order.id, aid: @activity.id) } }
    else
      render json: { ajax_msg: { status: -1 } }
    end
  end

  def send_sms
    session[:captcha] = rand(999999)
    session[:mobile]  = params[:phone]
    SmsAlidayu.new.send_code_for_verify(session[:mobile], session[:captcha])
    render text: nil
  end

  private

    def check_subscribe
      if @wx_user.present? #分为已关注(不作处理)和授权获得两种
        if @wx_mp_user.try(:auth_service?) && @wx_mp_user.is_oauth?
          attrs = Weixin.get_wx_user_info(@wx_mp_user, @wx_user.openid)
          @wx_user.update_attributes(attrs) if attrs.present?
          if @wx_user.unsubscribe? && !@activity.require_wx_user?
              return redirect_to mobile_unknown_identity_url(@activity.site_id, aid: @activity.id)
          end
        end
      else #非认证授权服务号的情况
        if !@activity.require_wx_user? #需要关注的情况
          return redirect_to mobile_unknown_identity_url(@activity.site_id, aid: @activity.id)
        else #创建虚拟wx_user
          #use session.id in Rails 4.
          @wx_user =  SessionUser.where(openid: request.session_options[:id], site_id: @site.id).first_or_create
          @user = @wx_user
        end
      end
    end

    def find_order
      @order = ReservationOrder.find_by_id(params[:id]) || ReservationOrder.new
    end

    def find_reservation
      session[:activity_id] ||= params[:aid]
      @activity = Activity.reservation.find(session[:activity_id])

      @share_title = @activity.name
      @share_desc = @activity.summary.try(:squish)
      @share_image = @activity.pic_url
    end

    def captcha_invalid
      @activity.extend.captcha_required && (params[:captcha].to_i != session[:captcha].to_i || params[:mobile] != session[:mobile])
    end

end
