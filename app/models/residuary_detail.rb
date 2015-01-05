class ResiduaryDetail < ActiveRecord::Base
  has_one :individual_residuary_general_detail, class_name: "GeneralDetail", foreign_key: "individual_residuary_id"
  has_one :charity_residuary_general_detail, class_name: "CharityDetail", foreign_key: "charity_residuary_id"

  accepts_nested_attributes_for :individual_residuary_general_detail
  accepts_nested_attributes_for :charity_residuary_general_detail
end
