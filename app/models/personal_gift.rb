class PersonalGift < ActiveRecord::Base
    default_scope -> { order id: :asc }
  belongs_to :will
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :middle_name, length: { maximum: 200 }, allow_blank: true
  validates :surname, presence: true, length: { maximum: 100 }
  validates :postcode, presence: true, length: { maximum: 10 }
  validates :address_one, presence: true, length: { maximum: 100 }
  validates :address_two, length: { maximum: 100 }, allow_blank: true
  validates :city, presence: true, length: { maximum: 100 }
  validates :country, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }

  def full_name
    "#{self.first_name.titleize} #{self.middle_name.titleize if middle_name} #{self.surname.titleize}"
  end

  def full_address
    self.address_two == nil || self.address_two.gsub(/\s+/, "") == "" ? @addresstwo = "" : @addresstwo = self.address_two + ","
    self.county == nil || self.county.gsub(/\s+/, "") == ""  ? @county = "" : @county = self.county + ","
    "#{self.address_one.titleize}, #{@addresstwo} #{self.city.titleize}, #{@county} #{self.postcode.upcase}, #{self.country.titleize}"
  end

end
