class DiagnosisRecord < ApplicationRecord
  validates :body_score, presence: true
  validates :emotion_score, presence: true
  validates :mind_score, presence: true

  belongs_to :user
  belongs_to :diagnosis_result
  has_many :diagnosis_answers, dependent: :destroy
  accepts_nested_attributes_for :diagnosis_answers
end
