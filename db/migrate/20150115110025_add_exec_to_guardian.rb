class AddExecToGuardian < ActiveRecord::Migration
  def change
    add_column :guardians, :exec, :string
  end
end
