class Funeral < ActiveRecord::Base
  validates :preference, presence: true
  validates :wishes, length: { maximum: 2000 }
  validates :specific_organs, presence: true, length: { maximum: 200 }, if: :not_no_pref

  def not_no_pref
    if self.donate_organs == "yes_specific_organs"
      true
    else
      false
    end
  end


end