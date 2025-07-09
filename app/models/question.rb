class Question < ApplicationRecord
  validates :fatigue_category, presence: true, length: { maximum: 255 }
  validates :question_content, presence: true, length: { maximum: 255 }
  enum fatigue_category: { body: 0, emotion: 1, mind: 2 }
  
  has_many :diagnosis_answers
end
