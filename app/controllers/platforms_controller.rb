class PlatformsController < ApplicationController
  #skip_before_action :check_auth_mobile

  before_action do
    @partialLeftNav = "/layouts/partialLeftWeixin"
  end

  def bind
  	# if @wx_mp_user && !@wx_mp_user.cancel?
   #    return redirect_to platforms_path, alert: '您已经绑定过公众号'
   #  end
    redirect_uri = URI.encode_www_form_component "http://#{Settings.hostname}/wx_plugin/auth"
    redirect_to "https://mp.weixin.qq.com/cgi-bin/componentloginpage?component_appid=#{Settings.wx_plugin.component_app_id}&pre_auth_code=#{WxPluginService.pre_auth_code}&redirect_uri=#{redirect_uri}&account_id=#{current_user.id}"
  end

end
