class Question < ApplicationRecord
  validates :fatigue_category, presence: true, length: { maximum: 255 }
  validates :question_content, presence: true, length: { maximum: 255 }
  enum fatigue_category: { body: 1, emotion: 2, mind: 3 }
  
  has_many :diagnosis_answers
end
