class Order < ApplicationRecord
  belongs_to :school
  has_many :recipients, through: :order_recipients

  STATUS = %w( ORDER_RECEIVED ORDER_PROCESSING ORDER_SHIPPED ORDER_CANCELED).freeze
  validates :status, presence: true, inclusion: { in: STATUS }
end
