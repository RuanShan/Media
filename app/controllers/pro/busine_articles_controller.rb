class Pro::BusineArticlesController < WebsiteShared::WebsiteArticlesController

  before_action :require_business_website

  private
  def find_website_article
    require_business_website
    @website_article = @website.website_articles.find params[:id]
  end

end
