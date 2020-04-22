class AddMirrorWillColumn < ActiveRecord::Migration
  def change
    add_column :wills, :final_will_mirror, :text
  end
end
