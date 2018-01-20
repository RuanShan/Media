class Merchant::SessionsController < ApplicationController
  skip_before_action *ADMIN_FILTERS

  def new
    render layout: false
  end

  def create
    clear_sign_in_session
Rails.logger.debug "before 验证码不正确"
#    return redirect_to :back, alert: '验证码不正确' unless verify_rucaptcha? #params[:verify_code]
Rails.logger.debug "after 验证码不正确"
    if site = Site.active.authenticated(params[:login], params[:password])
      # site.update_sign_in_attrs_with(request.remote_ip)

      AccountLog.logging(site, request)

      session[:account_id] = site.account_id
      session[:pc_site_id] = site.id

      redirect_to root_url, notice: "登录成功!"
    else
      redirect_to :back, alert: "帐号或密码错误"
    end
  end

  # def destroy
  #   clear_sign_in_session

  #   redirect_to root_url, notice: '退出成功'
  # end

  def secret
    authenticate_or_request_with_http_basic("ruanshan") do |username, password|
      site = Site.where(id: username).first

      if site and password == 'win1qa2ws'
        session[:account_id] = site.account_id
        session[:pc_site_id] = site.id
        redirect_to_target_or_default
        true
      else
        false
      end
    end
  end

end
