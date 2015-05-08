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
    self.address_one == nil || self.address_one.gsub(/\s+/, "") == "" ? @addressone = "" : @addressone = self.address_one.titleize + ","
    self.address_two == nil || self.address_two.gsub(/\s+/, "") == "" ? @addresstwo = "" : @addresstwo = self.address_two.titleize + ","
    self.city == nil || self.city.gsub(/\s+/, "") == ""  ? @city = "" : @city = self.city.titleize + ","
    self.county == nil || self.county.gsub(/\s+/, "") == ""  ? @county = "" : @county = self.county.titleize + ","
    self.postcode == nil || self.postcode.gsub(/\s+/, "") == ""  ? @postcode = "" : @postcode = self.postcode.upcase + ","
    self.country == nil || self.country.gsub(/\s+/, "") == ""  ? @country = "" : @country = self.country.titleize
    "#{@addressone} #{@addresstwo} #{@city} #{@county} #{@postcode} #{@country}"
  end

end
