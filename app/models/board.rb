class Board < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  paginates_per 20

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  mount_uploader :board_image, BoardImageUploader

  def self.ransackable_attributes(_auth_object = nil)
    %w[title body]
  end

  def self.ransackable_associations(auth_object = nil)
    ["bookmarks", "comments", "user"]
  end  
end  