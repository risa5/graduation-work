class User < ApplicationRecord
  authenticates_with_sorcery!
  attr_accessor :remember_token

  validates :password, length: { minimum: 3 }, if: :password_required?
  validates :password, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :boards, dependent: :destroy
  has_many :diagnosis_records
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board
  has_many :likes, dependent: :destroy
  has_many :like_boards, through: :likes, source: :board

  mount_uploader :image, ImageUploader

  enum role: { general: 0, admin: 1 }

  paginates_per 20
  
  def password_required?
    provider.blank? && (new_record? || changes[:crypted_password])
  end

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

  def User.new_token
    SecureRandom.urlsafe_base64
  end
end
