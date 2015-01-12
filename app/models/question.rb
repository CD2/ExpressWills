class Question < ActiveRecord::Base
  validates :number, presence: true, uniqueness: true
  default_scope -> { order number: :asc }
end