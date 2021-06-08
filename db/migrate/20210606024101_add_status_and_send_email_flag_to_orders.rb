class AddStatusAndSendEmailFlagToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :string, default: "ORDER_RECEIVED" 
    add_column :orders, :send_email, :boolean, default: false
  end
end
