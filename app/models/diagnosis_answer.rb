class DiagnosisAnswer < ApplicationRecord
  belongs_to :choice
  belongs_to :diagnosis_result
  belongs_to :question
  belongs_to :diagnosis_record
end
