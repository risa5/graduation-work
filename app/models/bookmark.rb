class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :board

  paginates_per 20

  validates :user_id, uniqueness: { scope: :board_id }
end
