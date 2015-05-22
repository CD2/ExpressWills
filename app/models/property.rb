class Property < ActiveRecord::Base
  belongs_to :will
  default_scope -> { order id: :asc }
  has_one :benificiary_general_details, class_name: "GeneralDetail", foreign_key: "benificiary_id"
  has_one :second_benificiary_general_details, class_name: "GeneralDetail", foreign_key: "second_benificiary_id"
  has_one :third_benificiary_general_details, class_name: "GeneralDetail", foreign_key: "third_benificiary_id"
  has_one :forth_benificiary_general_details, class_name: "GeneralDetail", foreign_key: "forth_benificiary_id"
  has_one :replacement_benificiary_general_details, class_name: "GeneralDetail", foreign_key: "replacement_benificiary_id"
  has_one :second_replacement_benificiary_general_details, class_name: "GeneralDetail", foreign_key: "second_replacement_benificiary_id"
  has_one :third_replacement_benificiary_general_details, class_name: "GeneralDetail", foreign_key: "third_replacement_benificiary_id"
  has_one :forth_replacement_benificiary_general_details, class_name: "GeneralDetail", foreign_key: "forth_replacement_benificiary_id"

  accepts_nested_attributes_for :benificiary_general_details
  accepts_nested_attributes_for :second_benificiary_general_details
  accepts_nested_attributes_for :third_benificiary_general_details
  accepts_nested_attributes_for :forth_benificiary_general_details
  accepts_nested_attributes_for :replacement_benificiary_general_details
  accepts_nested_attributes_for :second_replacement_benificiary_general_details
  accepts_nested_attributes_for :third_replacement_benificiary_general_details
  accepts_nested_attributes_for :forth_replacement_benificiary_general_details

  validates :land_reg_number, length: { maximum: 20 }, allow_blank: true
  validates :postcode, presence: true, length: { maximum: 10 }
  validates :address_one, presence: true, length: { maximum: 100 }
  validates :address_two, length: { maximum: 100 }, allow_blank: true
  validates :city, presence: true, length: { maximum: 100 }
  validates :country, presence: true, length: { maximum: 100 }

  def full_address
    self.address_one == nil || self.address_one.gsub(/\s+/, "") == "" ? @addressone = "" : @addressone = self.address_one.titleize + ","
    self.address_two == nil || self.address_two.gsub(/\s+/, "") == "" ? @addresstwo = "" : @addresstwo = self.address_two.titleize + ","
    self.city == nil || self.city.gsub(/\s+/, "") == ""  ? @city = "" : @city = self.city.titleize + ","
    self.county == nil || self.county.gsub(/\s+/, "") == ""  ? @county = "" : @county = self.county.titleize + ","
    self.postcode == nil || self.postcode.gsub(/\s+/, "") == ""  ? @postcode = "" : @postcode = self.postcode.upcase + ","
    self.country == nil || self.country.gsub(/\s+/, "") == ""  ? @country = "" : @country = self.country.upcase
    "#{@addressone} #{@addresstwo} #{@city} #{@county} #{@postcode} #{@country}"
  end


  def beneficiaries
    array = []
    array << self.benificiary_general_details if self.benificiary_general_details
    array << self.second_benificiary_general_details if self.second_benificiary_general_details
    array << self.third_benificiary_general_details if self.third_benificiary_general_details
    array << self.forth_benificiary_general_details if self.forth_benificiary_general_details
    return array
  end

  def life_beneficiaries
    array = []
    array << self.replacement_benificiary_general_details if self.replacement_benificiary_general_details
    array << self.second_replacement_benificiary_general_details if self.second_replacement_benificiary_general_details
    array << self.third_replacement_benificiary_general_details if self.third_replacement_benificiary_general_details
    array << self.forth_replacement_benificiary_general_details if self.forth_replacement_benificiary_general_details
    return array
  end

end
