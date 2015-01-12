class AddTermsToWill < ActiveRecord::Migration
  def change
    add_column :wills, :term, :boolean
  end
end
