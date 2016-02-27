class AddGoldToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :gold, :boolean, default: false
  end
end
