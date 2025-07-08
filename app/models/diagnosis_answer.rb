class DiagnosisAnswer < ApplicationRecord
  belongs_to :choices
  belongs_to :diagnosis_results
  belongs_to :questions
end
