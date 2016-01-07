class Booking < ActiveRecord::Base
  #mount_uploader :logo, WebsiteUploader

  belongs_to :supplier
  belongs_to :wx_mp_user

  has_one :activity, as: :activityable, dependent: :destroy

  validates :name, presence: true, length: { maximum: 64, message: '名称过长' }
  validates :tel, presence: true, on: :update

  accepts_nested_attributes_for :activity

  def clear_menus!
    supplier.booking_categories.clear
  end

  def multilevel_menu params
    return [1, []] unless supplier
    booking_categories, booking_categories_selects = supplier.booking_categories.root.order(:sort), []
    index = 1
    booking_categories_selects.push([index, booking_categories])
    return booking_categories_selects if params["booking_category_id#{index}".to_sym].to_i <= 0 && params[:action] == 'index'
    if params["booking_category_id#{index}".to_sym].present?
      booking_categories.where(id: params["booking_category_id#{index}".to_sym].to_i).first.try(:multilevel_menu_down, index + 1, params, booking_categories_selects)
    else
      booking_categories.first.try(:multilevel_menu_down, index + 1, params, booking_categories_selects)
    end
    booking_categories_selects
  end

  def show_items params

    return [] unless supplier
    items = []
    supplier.booking_categories.root.each do |category|
      if category.has_children?
        if category.id == params[:booking_category_id].to_i
          items << category.booking_items
          category.items params, items, true
        else
          category.items params, items
        end
      else
        next unless category.id == params[:booking_category_id].to_i
        items << category.booking_items
      end
    end if params[:booking_category_id].present?

    items = supplier.booking_items unless params[:booking_category_id].present?

    items = items.flatten

    items = items.select{|item| item.id == params[:id].to_i} if params[:id].present?

    items = items.select{|item| item.name =~ /.*(#{params[:name].strip()}).*/} if params[:name].present?

    items.flatten.sort{|x, y| y.created_at <=> x.created_at }
  end


end