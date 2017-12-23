class BookingAd < ActiveRecord::Base
  belongs_to :booking

  validates :title, presence: true
  validates :url, format: { with: /\A(http|https):\/\/[a-zA-Z0-9].+\z/, message: '地址格式不正确，必须以http(s)://开头' }, allow_blank: true

  def pic_url
    qiniu_image_url(pic_key)
  end
end