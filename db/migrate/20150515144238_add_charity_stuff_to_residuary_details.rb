class AddCharityStuffToResiduaryDetails < ActiveRecord::Migration
  def change
    add_column :residuary_details, :popular_charity, :string
    add_column :residuary_details, :popular_charity_name, :string
  end
end
