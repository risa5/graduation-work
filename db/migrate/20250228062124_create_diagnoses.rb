class CreateDiagnoses < ActiveRecord::Migration[7.2]
  def change
    create_table :diagnoses do |t|
      t.string :question1, null: false # 必要なもの
      t.string :question2, null: false # 癒しにかけられる時間
      t.string :question3, null: false # 気分
      t.string :result # 診断結果

      t.timestamps
    end
  end
end
