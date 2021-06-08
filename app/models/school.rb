class School < ApplicationRecord
  has_many :orders
  has_many :recipients
end
