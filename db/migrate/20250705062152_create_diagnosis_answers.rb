class CreateDiagnosisAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :diagnosis_answers do |t|
      t.references :diagnosis_record, foreign_key: true
      t.references :question, foreign_key: true
      t.references :choice, foreign_key: true

      t.timestamps
    end
  end
end
