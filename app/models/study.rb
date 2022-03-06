class Study < ApplicationRecord
  belongs_to :user
  belongs_to :profile, optional: true
end
