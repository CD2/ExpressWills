class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :full_name
      t.string :email_address
      t.integer :will_id

      t.timestamps
    end
  end
end
