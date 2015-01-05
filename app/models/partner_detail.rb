class PartnerDetail < ActiveRecord::Base
  validates :phone_no, length: { maximum: 20 }, allow_blank: true

  has_one :general_detail
  accepts_nested_attributes_for :general_detail
end
