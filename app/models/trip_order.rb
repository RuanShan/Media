class TripOrder < ActiveRecord::Base
  #status:状态（1:已预约、2:已取消、3:已过期）
  belongs_to :trip
  belongs_to :trip_ticket

  validates :username, :tel, presence: true

  before_save :set_default_attrs

  private

  def set_default_attrs
    now = Time.now
    self.order_no = [now.to_s(:number), now.usec.to_s.ljust(6, '0')].join
    self.total_amount = self.qty * self.price

    return unless self.trip

    self.supplier_id = self.trip.supplier_id
    self.wx_mp_user_id = self.trip.wx_mp_user_id
  end
end
