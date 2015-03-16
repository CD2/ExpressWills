class CharityDetail < ActiveRecord::Base
    default_scope -> { order id: :asc }
  belongs_to :will
  
  validates :name, presence: true, length: { maximum: 200 }

  belongs_to :charity_residuary, class_name: 'ResiduaryDetail'

  def full_address
    self.address_two == nil || self.address_two.gsub(/\s+/, "") == "" ? @addresstwo = "" : @addresstwo = self.address_two + ","
    self.county == nil || self.county.gsub(/\s+/, "") == ""  ? @county = "" : @county = self.county + ","
    "#{self.address_one.titleize}, #{@addresstwo} #{self.city.titleize}, #{@county} #{self.postcode.upcase}, #{self.country.titleize}"
  end

end
