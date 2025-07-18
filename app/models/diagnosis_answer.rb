class DiagnosisAnswer < ApplicationRecord
  belongs_to :diagnosis_record
  belongs_to :question
  belongs_to :choice
end
