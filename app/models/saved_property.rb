class SavedProperty < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :property
end
