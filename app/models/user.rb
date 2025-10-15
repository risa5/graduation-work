class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :boards, dependent: :destroy
  has_many :diagnosis_records
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board
  has_many :likes, dependent: :destroy

  mount_uploader :image, ImageUploader

  enum role: { general: 0, admin: 1 }

  def self.ransackable_attributes(_auth_object = nil)
    ["name", "role"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["name", "role"]
  end

  #　ログインしているuserのIDとオブジェクトのuserIDが一致するか確認するメソッド 
  def own?(object)
    id == object&.user_id
  end

  def bookmark(board)
    bookmark_boards << board
  end

  def unbookmark(board)
    bookmark_boards.destroy(board)
  end

  def bookmark?(board)
    bookmark_boards.include?(board)
  end
end
