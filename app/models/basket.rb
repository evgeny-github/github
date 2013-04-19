class Basket < ActiveRecord::Base
  belongs_to :user
  belongs_to :good

  validates_presence_of :delivery_status

  def cost
  	price*count
  end


  def __complete_delivery
    self.send_date = Time.now
    self.delivery_status = 'completed'
    self.save
  end

  def __change_delivery_status_to_requested(status)
  	if status
	    self.delivery_status = 'requested'
    else
      self.delivery_status = 'new' if self.send_date.nil?
    end
    self.save
  end

  def Basket.__to_basket(user_id, good_id, quantity)
    basket = Basket.find_by_user_id_and_good_id_and_delivery_status user_id, good_id, 'new'
    basket = Basket.new({:user => User.find(user_id), good_id: good_id, count: 0, delivery_status: 'new', price: Good.find(good_id).price}) if basket.nil?
    basket.count += quantity.to_i
    basket.save
    basket
  end


  def Basket.__set_delivery_status_to_new(user_id)
  	self.update_all("delivery_status = 'new'", "user_id = #{user_id} and send_date is NULL")
  end


  scope :with_names,
    joins: "join goods on baskets.good_id = goods.id"

  scope :not_sent, conditions: ["send_date is NULL"]

  scope :order, lambda { | order |
    {
      order: order
    }
  }

  scope :user_basket, lambda { | user_id |
    {
      conditions: "user_id = '#{user_id}'"
    }
  }

  scope :send_or_requested, lambda { | user_id |
    {
      conditions: "user_id = '#{user_id}' AND (send_date is not NULL OR delivery_status = 'requested')",
      order: "delivery_status DESC, send_date DESC"
    }
  }


  scope :were_requested, group: "user_id", 
    conditions: "delivery_status = 'requested'"

end
