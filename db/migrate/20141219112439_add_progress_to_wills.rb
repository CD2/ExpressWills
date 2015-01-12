class AddProgressToWills < ActiveRecord::Migration
  def change
    add_column :wills, :progress, :integer, default: 0
  end
end
