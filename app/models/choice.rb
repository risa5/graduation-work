class Choice < ApplicationRecord
  validates :question, presence: true, length: { maximum: 255 }
  validates :choice_content, presence: true, length: { maximum: 255 }
  validates :score, presence: true

  has_many :diagnosis_answers
end
