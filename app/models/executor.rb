class Executor < ActiveRecord::Base

  has_one :first_executor_general_detail, class_name: "GeneralDetail", foreign_key: "first_executor_id"
  has_one :second_executor_general_detail, class_name: "GeneralDetail", foreign_key: "second_executor_id"
  has_one :third_executor_general_detail, class_name: "GeneralDetail", foreign_key: "third_executor_id"
  has_one :forth_executor_general_detail, class_name: "GeneralDetail", foreign_key: "forth_executor_id"
  has_one :first_replacement_executor_general_detail, class_name: "GeneralDetail", foreign_key: "first_replacement_executor_id"
  has_one :second_replacement_executor_general_detail, class_name: "GeneralDetail", foreign_key: "second_replacement_executor_id"
  has_one :third_replacement_executor_general_detail, class_name: "GeneralDetail", foreign_key: "third_replacement_executor_id"
  has_one :forth_replacement_executor_general_detail, class_name: "GeneralDetail", foreign_key: "forth_replacement_executor_id"

  accepts_nested_attributes_for :first_executor_general_detail
  accepts_nested_attributes_for :second_executor_general_detail
  accepts_nested_attributes_for :third_executor_general_detail
  accepts_nested_attributes_for :forth_executor_general_detail
  accepts_nested_attributes_for :first_replacement_executor_general_detail
  accepts_nested_attributes_for :second_replacement_executor_general_detail
  accepts_nested_attributes_for :third_replacement_executor_general_detail
  accepts_nested_attributes_for :forth_replacement_executor_general_detail

  validates_inclusion_of :first, :in => [true, false], if: :notary_false
  validates_inclusion_of :second, :in => [true, false], unless: :notary_false

  def notary_false
    if self.notary_express
      false
    else
      true
    end
  end

end
