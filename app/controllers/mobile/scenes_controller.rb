class Mobile::ScenesController < Mobile::BaseController
  layout 'mobile/scenes'

  skip_before_action :load_user_data, :auth, :authorize

  before_action  :require_wx_mp_user, :set_activity

  def index
    if @scene_html.try(:version).present?
      render "index_#{@scene_html.version}", layout: false # "mobile/scenes_#{@scene_html.version}"
    else
      render "index"
    end
  end

  private

  def set_activity
    @activity =  @site.activities.scene.show.find_by_id(params[:aid]) || @site.activities.scene.find_by_id(session[:activity_id])
    return render_404 unless @activity
    @share_image = @activity.share_setting_pic_url || @activity.pic_url
    @share_title = @activity.share_setting_title || @activity.name
    @share_desc = @activity.share_setting_summary || @activity.summary.try(:squish)
    @not_show_copyroght = true
    @scene_html = @activity.scene_html
  end
end
