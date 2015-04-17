class CreatePersonalGiftPermissions < ActiveRecord::Migration
  def change
    create_table :personal_gift_permissions do |t|
      t.boolean :permission
      t.integer :will_id

      t.timestamps
    end
  end
end
