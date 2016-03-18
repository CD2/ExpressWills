class AddWillReviewToWills < ActiveRecord::Migration
  def change
    add_column :wills, :final_will, :text
  end
end
