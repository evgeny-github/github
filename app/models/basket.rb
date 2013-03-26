class Basket < ActiveRecord::Base
  belongs_to :user
  belongs_to :good

  def cost
  	price*count
  end

  def __complete_delivery
  	# raise 'Method moved to BASKET model'
    self.send_date = Time.now
    self.delivery_status = 'completed'
    self.save
  end

  def __change_delivery_status_to_requested(status)
  	if status
	  self.delivery_status = 'requested'
    else
	  if self.send_date.nil?
	      self.delivery_status = 'new'
	  end
    end
    self.save
  end


  def Basket.__set_delivery_status_to_new(user_id)
  	self.update_all("delivery_status = 'new'", "user_id = #{user_id} and send_date is NULL")
  end


  scope :send_of_requested,
    conditions: "user_id = 'current_user_id' AND (send_date is not NULL OR delivery_status = 'requested')",
    order: "delivery_status DESC, send_date DESC"

end
