class Good < ActiveRecord::Base
  has_many :baskets

  validates_uniqueness_of :title, :case_sensitive => false
  validates_presence_of :price, :count

  validates_format_of :title,
    message: 'field can contain only space char and letters (case insensitive)',
    with: /\A\s*([a-z]+ ?)*\Z/i
end
