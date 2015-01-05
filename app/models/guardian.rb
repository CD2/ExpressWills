class Guardian < ActiveRecord::Base

  has_one :first_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "first_guardian_id"
  has_one :second_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "second_guardian_id"
  has_one :third_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "third_guardian_id"
  has_one :forth_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "forth_guardian_id"
  has_one :first_replacement_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "first_replacement_guardian_id"
  has_one :second_replacement_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "second_replacement_guardian_id"
  has_one :third_replacement_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "third_replacement_guardian_id"
  has_one :forth_replacement_guardian_general_detail, class_name: "GeneralDetail", foreign_key: "forth_replacement_guardian_id"

  accepts_nested_attributes_for :first_guardian_general_detail
  accepts_nested_attributes_for :second_guardian_general_detail
  accepts_nested_attributes_for :third_guardian_general_detail
  accepts_nested_attributes_for :forth_guardian_general_detail
  accepts_nested_attributes_for :first_replacement_guardian_general_detail
  accepts_nested_attributes_for :second_replacement_guardian_general_detail
  accepts_nested_attributes_for :third_replacement_guardian_general_detail
  accepts_nested_attributes_for :forth_replacement_guardian_general_detail
  
end
