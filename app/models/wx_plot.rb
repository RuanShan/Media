class WxPlot < ActiveRecord::Base

  attr_accessor :is_delete_cover_pic

  belongs_to :site
  has_many :wx_plot_bulletins
  has_many :wx_plot_lives
  has_many :wx_plot_telephones
  has_many :activities, as: :activityable
  has_one :activity_wx_plot_bulletin, -> { where( activity_type_id: ActivityType::PLOT_BULLETIN) }, class_name: 'Activity', as: :activityable
  has_one :activity_wx_plot_repair, -> {  where( activity_type_id: ActivityType::PLOT_REPAIR) }, class_name: 'Activity', as: :activityable
  has_one :activity_wx_plot_complain, -> {  where( activity_type_id: ActivityType::PLOT_COMPLAIN) }, class_name: 'Activity', as: :activityable
  has_one :activity_wx_plot_owner, -> {  where( activity_type_id: ActivityType::PLOT_OWNER) }, class_name: 'Activity', as: :activityable
  has_one :activity_wx_plot_life, -> {  where( activity_type_id: ActivityType::PLOT_LIFE) }, class_name: 'Activity', as: :activityable
  has_one :activity_wx_plot_telephone, -> {  where( activity_type_id: ActivityType::PLOT_TELEPHONE) }, class_name: 'Activity', as: :activityable

  has_many :wx_plot_repair_complains, -> { order('wx_plot_repair_complains.created_at DESC') }
  has_many :repairs, -> { where( category: WxPlotRepairComplain::REPAIR).order('wx_plot_repair_complains.created_at DESC') },  class_name: 'WxPlotRepairComplain'
  has_many :complains, -> { where( category: WxPlotRepairComplain::COMPLAIN).order('wx_plot_repair_complains.created_at DESC') }, class_name: 'WxPlotRepairComplain'
  has_many :advices, -> { where( category: WxPlotRepairComplain::ADVICE).order('wx_plot_repair_complains.created_at DESC') }, class_name: 'WxPlotRepairComplain'
  has_many :complain_advices, -> { where( category: [WxPlotCategory::COMPLAIN, WxPlotCategory::ADVICE]).order('wx_plot_repair_complains.created_at DESC') },  class_name: 'WxPlotRepairComplain'

  has_many :wx_plot_categories
  has_many :repair_categories, -> { where( category: WxPlotCategory::REPAIR) }, class_name: 'WxPlotCategory'
  has_many :complain_categories, -> { where( category: WxPlotCategory::COMPLAIN) }, class_name: 'WxPlotCategory'
  has_many :advice_categories, -> { where( category: WxPlotCategory::ADVICE) }, class_name: 'WxPlotCategory'
  has_many :complain_advice_categories, -> { where( category: [WxPlotCategory::COMPLAIN, WxPlotCategory::ADVICE] ) }, class_name: 'WxPlotCategory'
  has_many :telephone_categories, -> { where( category: WxPlotCategory::TELEPHONE ) }, class_name: 'WxPlotCategory'
  has_many :life_categories, -> { where( category: WxPlotCategory::LIFE ) }, class_name: 'WxPlotCategory'

  has_many :sms_settings, class_name: 'WxPlotSmsSetting', dependent: :destroy

  accepts_nested_attributes_for :wx_plot_categories, :sms_settings, :site, :allow_destroy => true
  accepts_nested_attributes_for :activities

  validates :site_id, :name, :bulletin, :repair, :complain, :telephone, :owner, :life, presence: true
  validates :repair_phone, format: { with: /\A[0-9_\-]*\z/, message: '联系电话格式不正确' }, allow_blank: true
  validates :complain_phone, format: { with: /\A[0-9_\-]*\z/, message: '联系电话格式不正确' }, allow_blank: true


  def cover_pic_url
    qiniu_image_url(read_attribute("cover_pic"))
  end
end
