class CharitableDonation < ActiveRecord::Base
    default_scope -> { order id: :asc }
  belongs_to :will

    validates :amount, presence: true, :format => { :with => /\A\d+(?:\.\d\d)?\z/ }, :numericality => {:greater_than => 0 }

    validates :name, presence: true, length: { maximum: 200 }, unless: "popular_charity"

    validates :instruction, length: { maximum: 2000 }, allow_blank: true

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
