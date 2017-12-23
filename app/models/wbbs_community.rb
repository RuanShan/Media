class WbbsCommunity < ActiveRecord::Base
  belongs_to :site
  has_many :wbbs_topics
  has_many :wbbs_replies
  has_one :activity, -> { where(activity_type_id: ActivityType::WBBS_COMMUNITY) }, as: :activityable
  accepts_nested_attributes_for :activity

  enum_attr :status, :in => [
    ['setted',    1, '已配置'],
    ['stopped', -1, '已停止'],
    ['deleted', -2, '已删除']
  ]

  def logo_url
    logo.present? ? qiniu_image_url(logo) : "/assets/wbbs.jpg"
  end

  def normal_users
    User.where(id: user_ids).message_normal
  end

  def users
    User.where(id: user_ids)
  end

  def user_ids
    (wbbs_topics.pluck(:poster_id) + wbbs_replies.pluck(:replier_id)).uniq.compact
  end

  def forbidden_users
    User.where(id: user_ids).message_forbidden
  end

  def mark_delete!
    activity.update_column(:status, Activity::DELETED) if activity
    update_column(:status, DELETED)
  end

  def wbbs_topics_count
    @wbbs_topics_count ||= wbbs_topics.normal.count
  end

  def wbbs_replies_count
    @wbbs_replies_count ||= wbbs_replies.normal.count
  end

  def create_wbbs_topics( content, poster )
    poster_name, poster_avatar = poster.try(:nickname), poster.try(:headimgurl)
    wbbs_topics.create( site_id: site_id || activity.site_id, content: content, poster: poster, poster_name: poster_name, poster_avatar: poster_avatar )
  end
end
