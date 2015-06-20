class CashGift < ActiveRecord::Base
    default_scope -> { order id: :asc }
  validates :amount, presence: true, :format => { :with => /\A\d+(?:\.\d\d)?\z/ }, :numericality => {:greater_than => 0, message: " must be a number"}
  belongs_to :will

  validates :first_name, presence: true, length: { maximum: 100 }, if: :no_children
  validates :middle_name, length: { maximum: 200 }, allow_blank: true, if: :no_children
  validates :surname, presence: true, length: { maximum: 100 }, if: :no_children
  validates :postcode, presence: true, length: { maximum: 10 }, if: :no_children
  validates :address_one, presence: true, length: { maximum: 100 }, if: :no_children
  validates :address_two, length: { maximum: 100 }, allow_blank: true, if: :no_children
  validates :city, presence: true, length: { maximum: 100 }, if: :no_children
  validates :country, presence: true, length: { maximum: 100 }, if: :no_children

  def no_children
    true if self.shared_to == "no"
  end

  
  def full_name
    "#{self.first_name.titleize} #{self.middle_name.titleize if middle_name} #{self.surname.titleize}"
  end

  def full_address
    self.address_one == nil || self.address_one.gsub(/\s+/, "") == "" ? @addressone = "" : @addressone = self.address_one + ","
    self.address_two == nil || self.address_two.gsub(/\s+/, "") == "" ? @addresstwo = "" : @addresstwo = self.address_two + ","
    self.city == nil || self.city.gsub(/\s+/, "") == ""  ? @city = "" : @city = self.city.titleize + ","
    self.county == nil || self.county.gsub(/\s+/, "") == ""  ? @county = "" : @county = self.county.titleize + ","
    self.postcode == nil || self.postcode.gsub(/\s+/, "") == ""  ? @postcode = "" : @postcode = self.postcode.upcase + ","
    self.country == nil || self.country.gsub(/\s+/, "") == ""  ? @country = "" : @country = self.country.upcase
    "#{@addressone} #{@addresstwo} #{@city} #{@county} #{@postcode} #{@country}"
  end

  
end
