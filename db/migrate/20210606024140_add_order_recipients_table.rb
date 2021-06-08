class AddOrderRecipientsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :order_recipients, id: false do |t|
      t.belongs_to :order
      t.belongs_to :recipient
      t.string :gift_type
      t.timestamps
    end
  end
end
