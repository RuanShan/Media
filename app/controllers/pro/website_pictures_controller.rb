class Pro::WebsitePicturesController < WebsiteShared::WebsitePicturesController
  before_action :set_life_website

  
  private
    def find_picture
      set_life_website
      @picture = @website.website_pictures.find params[:id]
    end
end
