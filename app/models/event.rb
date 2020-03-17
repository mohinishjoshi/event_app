class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :users, :through => :attendances

  def is_user_attending?(user)
    users.include?(user)
  end
end
