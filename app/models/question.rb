class Question < ApplicationRecord
  validates :fatigue_category, presence: true, length: { maximum: 255 }
  validates :question_content, presence: true, length: { maximum: 255 }
end
