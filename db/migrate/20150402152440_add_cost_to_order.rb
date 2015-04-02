class AddCostToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :price, :string
  end
end
