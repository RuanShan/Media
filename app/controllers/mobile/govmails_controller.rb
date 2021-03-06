class Mobile::GovmailsController < Mobile::BaseController
  layout "mobile/gov"
  before_action :set_activity

  def index
    @boxes = @activity.govmailboxes.normal
  end

  def my
    @mails = @user.govmails.order("created_at DESC") rescue []
  end

  def new
    @mail = Govmail.new
  end

  def create
    @box  = @activity.govmailboxes.find(params[:box])
    @mail = @box.govmails.create(user_id: session[:user_id], body: params[:body])
    if @mail.persisted?
      params[:custom_field].to_a.each do |key, value|
        field = CustomField.find(key)
        field.custom_values.create(customized: @mail, value: value)
      end
      render json: { ajax_msg: { status: 1, url: mobile_govmails_url(activity_id: @activity.id) } }
    else
      render json: { ajax_msg: { status: 0 } }
    end
  end

  private

  def set_activity
    @activity    = @site.activities.govmail.show.first || @site.create_activity_for_govmail
    @share_title = @activity.name
    @share_desc  = @activity.summary
    @share_image = @activity.pic_url
  end
end
