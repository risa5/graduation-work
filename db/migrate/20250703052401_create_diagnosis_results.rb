class CreateDiagnosisResults < ActiveRecord::Migration[7.2]
  def change
    create_table :diagnosis_results do |t|
      t.string :pattern_code, null: false
      t.string :result_summary, null: false
      t.text :suggestion, null: false      

      t.timestamps
    end
  end
end
