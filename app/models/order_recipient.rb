class OrderRecipient < ApplicationRecord
  belongs_to :order
  belongs_to :recipient

  GIFTS = %w( MUG T_SHIRT HOODIE STICKER).freeze
  validates :gift_type, inclusion: { in: GIFTS }
end