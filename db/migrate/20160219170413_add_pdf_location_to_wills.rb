class AddPdfLocationToWills < ActiveRecord::Migration
  def change
    add_column :wills, :pdf_locale, :string
  end
end
