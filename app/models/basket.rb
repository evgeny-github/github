class Basket < ActiveRecord::Base
  belongs_to :user
  belongs_to :good
end
