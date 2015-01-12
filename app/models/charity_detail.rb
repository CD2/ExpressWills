class CharityDetail < ActiveRecord::Base
  belongs_to :will
  
  validates :name, presence: true, length: { maximum: 200 }

  belongs_to :charity_residuary, class_name: 'ResiduaryDetail'

  def full_address
    self.address_one.titleize {+ ", " + self.address_two.titleize if address_two} + ", " + self.city.titleize + ", " + self.county.titleize + ", " + self.postcode.upcase + ", " + self.country.titleize
  end
end
