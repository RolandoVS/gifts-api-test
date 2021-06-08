class AddSchoolReferenceToRecipient < ActiveRecord::Migration[6.1]
  def change
    add_reference :recipients, :school, index: true
  end
end
