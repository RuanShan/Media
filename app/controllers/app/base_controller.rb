class App::BaseController < ActionController::Base
  include ErrorHandler, DetectUserAgent

  helper_method :judge_andriod_version, :wx_browser?

  before_action :redirect_to_non_openid_url, :load_site, :load_data, :load_user_data

  before_action :auth, if: -> { @wx_mp_user.try(:manual?) }
  before_action :authorize, if: -> { @wx_mp_user.try(:plugin?) }
  before_action :fetch_wx_user_info

  layout 'app'

  def load_data
    # session[:activity_id] = params[:activity_id] if params[:activity_id]
    session[:activity_id] = params[:aid] if params[:aid]
    session[:activity_notice_id] = params[:anid] if params[:anid]

    return render text: '该公众号服务已到期，暂不提供服务！' if @site.froze?

    @site_copyright = @site.copyright
  rescue => error
    logger.info "*********** app load_data error: #{error.message} > #{error.backtrace}"
    # render :text => "请求页面参数不正确"
    return redirect_to mobile_notice_url(msg: '请求参数不正确')
  end

  def app_params
    hash = {}
    hash[:aid]    = session[:activity_id]        if session[:activity_id]
    hash[:anid]   = session[:activity_notice_id] if session[:activity_notice_id]
    hash
  end

end
