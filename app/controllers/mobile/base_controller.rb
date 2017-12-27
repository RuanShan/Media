class Mobile::BaseController < ActionController::Base
  include ErrorHandler, DetectUserAgent

  before_action :redirect_to_non_openid_url, :load_site, :load_data, :load_user_data, except: [:notice]

  before_action :auth, if: -> { @wx_mp_user.try(:manual?) }
  before_action :authorize, if: -> { @wx_mp_user.try(:plugin?) }
  before_action :fetch_wx_user_info

  helper_method :judge_andriod_version, :wx_browser?

  def load_data
    # TODO 只投票有用，需要去掉
    # session[:activity_id] = params[:vote_id] if params[:vote_id].present?
    # session[:activity_id] = params[:activity_id] if params[:activity_id].present?
    session[:activity_id] = params[:aid] if params[:aid].present?
    session[:activity_notice_id] = params[:anid] if params[:anid].present?

    # session[:site_id] = params[:site_id] if params[:site_id].present?
    # @site = Site.find(session[:site_id].to_i)

    return render text: '该公众号服务已到期，暂不提供服务！' if @site.froze?

    # @wx_mp_user = @site.wx_mp_user
    require_wx_mp_user

    @site_copyright = @site.copyright
  rescue => error
    logger.info "*********** mobile load_data error: #{error.message} > #{error.backtrace}"
    # render :text => "请求页面参数不正确"
    return redirect_to mobile_notice_url(msg: '请求参数不正确')
  end

  def notice
  end

end
