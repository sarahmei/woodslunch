class UserOrder < Order
  belongs_to :user

  validates :user_id, :presence => true

  def self.order_for_date(user_id, date)
    find_by_user_id_and_served_on(user_id, date) ||
    UserOrder.new(:user_id => user_id, :served_on => date)
  end

  def self.create_or_update_via_params(params)
    params.values.each do |atts|
      order_id = atts.delete(:id)
      if order_id.blank?
        UserOrder.create!(atts) if create_order?(atts[:ordered_menu_items_attributes])
      else
        UserOrder.find(order_id).update_attributes!(atts)
      end
    end
  end
end