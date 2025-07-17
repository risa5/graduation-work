class Question < ApplicationRecord
  validates :fatigue_category, presence: true, length: { maximum: 255 }
  validates :question_content, presence: true, length: { maximum: 255 }
  enum fatigue_category: { body: 1, emotion: 2, mind: 3 }
  
  belongs_to :diagnosis_result
  has_many :choices
end
