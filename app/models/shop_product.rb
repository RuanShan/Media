class ShopProduct < ActiveRecord::Base

  validates :shop_menu_id, presence:true
  validates :name, presence: true, length: { maximum: 15 }

  validates :sort, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pic_key, presence: true, on: :create

  # validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_blank: true

  enum_attr :is_hot, :in => [ ['hot', true, '是'], ['not_hot', false, '否'] ]
  enum_attr :is_new, :in => [ ['new_proudcts', true, '是'], ['not_new', false, '否'] ]
  enum_attr :shelve_status, :in => [
    ['not_shelve', 0, '已下架'],
    ['shelve',     1, '已上架']
  ]

  belongs_to :site
  belongs_to :shop
  belongs_to :shop_category
  belongs_to :shop_menu
  has_many :shop_product_comments

  before_create :add_default_attrs

  default_scope ->{ where(["shop_products.status != ? ", -1 ]) }

  def self.import_from_excel(file, site)
    # Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet.open(file)
    sheet = book.worksheet(0)

    transaction do
      sheet.each_with_index do |row, i|
        next if i == 0

        shop_branch = site.shop_branches.where(name: row[0]).first
        shop_category = site.shop_categories.where(name: row[1]).first
        next unless shop_branch
        next unless shop_category

        puts row

        attrs = {
          shop_branch_id: shop_branch.id,
          shop_category_id: shop_category.id,
          name: row[2],
          price: row[3],

          is_new: row[5],
          is_hot: row[6],
          pic_url: row[7],
          description: row[8]
        }

        product = ShopProduct.where(name: row[2]).first

        product ? product.update_attributes(attrs) : ShopProduct.create(attrs)
      end
    end
  end

  # def pic_path
  #   "/uploads/shop_image/pic/#{shop_branch_id}/thumb_#{pic_url}"
  # end

  def bother_count
    if self.shop_category_id
      return self.shop_category.shop_products.count
    else
      return ShopProduct.where(category_parent_id: self.category_parent_id).count
    end
  end

  def pic_url_url
    qiniu_image_url(pic_key)
  end

  def thumb_qiniu_pic_url
    # 七牛缩略图说明 http://developer.qiniu.com/docs/v6/api/reference/fop/image/imageview2.html
    pic_url_url && "#{pic_url_url}?imageView2/1/w/60/h/60"
  end


  def update_sort sort_value
    same_sort_products = self.shop_menu.shop_products.where(sort: sort_value)
    same_sort_products.each do |p|
      unless p.id == self.id
        p.update_sort(p.sort + 1)
      end
    end
    self.update_column("sort", sort_value)
  end

  def soft_delete
    self.update_column("status", -1)
  end

  private

  def add_default_attrs
    return unless self.shop
    self.site_id = self.shop.site_id
    self.code = "#{self.category_parent_id}_#{self.shop.shop_products.count+1}"
    self.pic_url = self.pic_key if self.pic_key
  end


end
