class DiagnosisResult < ApplicationRecord
  validates :pattern_code, presence: true, length: { maximum: 255 }
  validates :result_summary, presence: true, length: { maximum: 255 }
  validates :suggestion, presence: true

  has_many :diagnosis_answers
  has_many :diagnosis_records
end
