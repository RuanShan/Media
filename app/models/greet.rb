class Greet < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :wx_mp_user
  belongs_to :activity
  # attr_accessible :name
  mount_uploader :greet_cover, GreetCardUploader
  has_many :greet_cards

  before_save :clean_up

  def greet_cover_url
    qiniu_image_url("greet_cover/#{greet_cover}") if greet_cover.present?
  end

  def clean_up
    self.greet_cover = nil if self.recommand_pic.present?
  end

  def recommand_pic_url
    self.recommand_pic.presence || "/assets/default_cards/top/1.png"
  end

end
