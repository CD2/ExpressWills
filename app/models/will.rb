class Will < ActiveRecord::Base
  has_one :testator_detail
  has_one :partner_detail
  has_one :funeral
  has_one :executor
  has_one :administration
  has_one :guardian
  has_one :residuary
  has_one :request
  has_many :cash_gifts
  has_many :charitable_donations
  has_one :charity_permission
  has_many :residuary_details
  has_many :personal_gifts
  has_many :properties
  has_one :residuary
  belongs_to :user

  has_one :testator_general_details, through: :testator_detail, source: :general_detail
  has_one :partner_general_details, through: :partner_detail, source: :general_detail
  has_one :first_executor, through: :executor, source: :first_executor_general_detail
  has_one :second_executor, through: :executor, source: :second_executor_general_detail
  has_one :third_executor, through: :executor, source: :third_executor_general_detail
  has_one :forth_executor, through: :executor, source: :forth_executor_general_detail
  has_one :first_replacement_executor, through: :executor, source: :first_replacement_executor_general_detail
  has_one :second_replacement_executor, through: :executor, source: :second_replacement_executor_general_detail
  has_one :third_replacement_executor, through: :executor, source: :third_replacement_executor_general_detail
  has_one :forth_replacement_executor, through: :executor, source: :forth_replacement_executor_general_detail
  has_one :first_guardian, through: :guardian, source: :first_guardian_general_detail
  has_one :second_guardian, through: :guardian, source: :second_guardian_general_detail
  has_one :third_guardian, through: :guardian, source: :third_guardian_general_detail
  has_one :forth_guardian, through: :guardian, source: :forth_guardian_general_detail
  has_one :first_replacement_guardian, through: :guardian, source: :first_replacement_guardian_general_detail
  has_one :second_replacement_guardian, through: :guardian, source: :second_replacement_guardian_general_detail
  has_one :third_replacement_guardian, through: :guardian, source: :third_replacement_guardian_general_detail
  has_one :forth_replacement_guardian, through: :guardian, source: :forth_replacement_guardian_general_detail

  validates :title, presence: true
  
end
