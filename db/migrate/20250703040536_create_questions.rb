class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.string :fatigue_category, null: false
      t.string :question_content, null: false

      t.timestamps
    end
  end
end
