class AddExecToExecutor < ActiveRecord::Migration
  def change
    add_column :executors, :exec, :string
  end
end
