class DiagnosisRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :diagnosis_result
  has_many   :diagnosis_answers, inverse_of: :diagnosis_record, dependent: :destroy

  accepts_nested_attributes_for :diagnosis_answers

  validates :body_score,    presence: true
  validates :emotion_score, presence: true
  validates :mind_score,    presence: true
end