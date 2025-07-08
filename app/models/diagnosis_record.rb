class DiagnosisRecord < ApplicationRecord
  validates :body_score, presence: true
  validates :emotion_score, presence: true
  validates :mind_score, presence: true


  belongs_to :user
  belongs_to :diagnosis_records
end
