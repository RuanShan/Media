class Pro::WebsiteMenusController < WebsiteShared::WebsiteMenusController
  before_action :set_life_website
  before_action :set_website_menu, only: [:show, :edit, :update, :destroy, :reorder]
end
