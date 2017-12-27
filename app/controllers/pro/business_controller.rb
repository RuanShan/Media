class Pro::BusinessController < WebsiteShared::WebsitesController
  before_action :require_business_website, except: :index
  before_action :require_business_industry, :set_website

  def address
  	render "pro/websites/address"
  end

  private
    def set_website
      @website = current_site.circle || current_site.wx_mp_user.create_circle
      @website = current_site.wx_mp_user.create_circle unless @website.circle_activity
    end

end
