class GeneralDetail < ActiveRecord::Base
  default_scope -> { order id: :asc }
  belongs_to :will
  belongs_to :testator_detail
  belongs_to :partner_detail
  belongs_to :first_executor, class_name: 'Executor'
  belongs_to :second_executor, class_name: 'Executor'
  belongs_to :third_executor, class_name: 'Executor'
  belongs_to :forth_executor, class_name: 'Executor'
  belongs_to :first_replacement_executor, class_name: 'Executor'
  belongs_to :second_replacement_executor, class_name: 'Executor'
  belongs_to :third_replacement_executor, class_name: 'Executor'
  belongs_to :forth_replacement_executor, class_name: 'Executor'
  belongs_to :first_guardian, class_name: 'Guardian'
  belongs_to :second_guardian, class_name: 'Guardian'
  belongs_to :third_guardian, class_name: 'Guardian'
  belongs_to :forth_guardian, class_name: 'Guardian'
  belongs_to :first_replacement_guardian, class_name: 'Guardian'
  belongs_to :second_replacement_guardian, class_name: 'Guardian'
  belongs_to :third_replacement_guardian, class_name: 'Guardian'
  belongs_to :forth_replacement_guardian, class_name: 'Guardian'
  belongs_to :benificiary_general_details, class_name: 'Property'
  belongs_to :second_benificiary_general_details, class_name: 'Property'
  belongs_to :third_benificiary_general_details, class_name: 'Property'
  belongs_to :forth_benificiary_general_details, class_name: 'Property'
  belongs_to :replacement_benificiary_general_details, class_name: 'Property'
  belongs_to :second_replacement_benificiary_general_details, class_name: 'Property'
  belongs_to :third_replacement_benificiary_general_details, class_name: 'Property'
  belongs_to :forth_replacement_benificiary_general_details, class_name: 'Property'
  belongs_to :individual_residuary, class_name: 'ResiduaryDetail'

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :middle_name, length: { maximum: 200 }, allow_blank: true
  validates :surname, presence: true, length: { maximum: 100 }
  validates :postcode, presence: true, length: { maximum: 10 }
  validates :address_one, presence: true, length: { maximum: 100 }
  validates :address_two, length: { maximum: 100 }, allow_blank: true
  validates :city, presence: true, length: { maximum: 100 }
  validates :country, presence: true, length: { maximum: 100 }

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
