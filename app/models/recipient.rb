class Recipient < ApplicationRecord
  belongs_to :school
  has_many :orders, through: :order_recipients
end
