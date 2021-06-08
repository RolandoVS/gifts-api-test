class AddSchoolReferenceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :school, index: true
  end
end
