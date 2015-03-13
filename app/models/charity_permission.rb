class CharityPermission < ActiveRecord::Base
    default_scope -> { order id: :asc }
  belongs_to :will
end
