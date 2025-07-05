class CreateDiagnosisRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :diagnosis_records do |t|
      t.references :user, foreign_key: true
      t.integer :body_score, null: false
      t.integer :emotion_score, null: false
      t.integer :mind_score, null: false
      t.references :diagnosis_result, foreign_key: true

      t.timestamps
    end
  end
end
