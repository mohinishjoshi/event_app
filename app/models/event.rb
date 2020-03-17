class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  has_many :attendances

  def is_user_attending?(user)
    attendances.pluck(:user_id).include?(user.id)
  end
end
