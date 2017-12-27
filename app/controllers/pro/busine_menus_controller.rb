class Pro::BusineMenusController < WebsiteShared::WebsiteMenusController

  before_action :require_business_industry, :require_business_website
  before_action :set_website_menu, only: [:show, :edit, :update, :destroy, :reorder]

end
