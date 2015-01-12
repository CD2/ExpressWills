class Request < ActiveRecord::Base
  validates :specific, length: { maximum: 5000 }, allow_blank: true
end
