module Concerns::ActivityHelper
  class << self

    def sn_code_count_for_activity( activity )
      return 0 unless activity
      if activity.old_coupon?
        activity.activity_properties.first.try(:coupon_count)
      elsif activity.activity_type.groups?
        activity.activity_consumes.count
      else
        activity.activity_prizes.sum(:prize_count)
      end
    end

    def sn_code_count_for_activity_type( supplier, activity_type_id, activity_ids )
      activity_type = ActivityType.where(id: activity_type_id).first
      return 0 unless activity_type
      if activity_type.consume?
        supplier.activities.where(activity_type_id: activity_type_id).joins(:activity_property).sum('activity_properties.coupon_count')
      elsif activity_type.groups?
        supplier.activity_consumes.where("activity_group_id is not null").count
      else
        ActivityPrize.where(activity_id: activity_ids).sum(:prize_count)
      end
    end

  end
end
