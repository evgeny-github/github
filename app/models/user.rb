class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :baskets


  # def User.__has_request

  scope :with_requests, group: "users.id",
    joins: "join baskets on baskets.user_id = users.id",
    conditions: "delivery_status = 'requested'"

end
