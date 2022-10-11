class SavedProperty < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :property

  validate :check_user_role

  def check_user_role
    return unless user.role == "landlord"

    errors.add :base, :invalid, message: "The user should be a homeseeker to save a property"
    Rails.logger.debug(errors.full_messages)
    throw :abort
  end
end
