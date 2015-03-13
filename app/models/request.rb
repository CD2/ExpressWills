class Request < ActiveRecord::Base
    default_scope -> { order id: :asc }
  validates :specific, length: { maximum: 5000 }, allow_blank: true
end
