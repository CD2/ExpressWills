class AddCharityStuffToCharityDetail < ActiveRecord::Migration
  def change
    add_column :charity_details, :popular_charity, :boolean
  end
end
