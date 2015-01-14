class AddTcToWills < ActiveRecord::Migration
  def change
    add_column :wills, :tc, :string
  end
end
