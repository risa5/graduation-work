class CreateChoices < ActiveRecord::Migration[7.2]
  def change
    create_table :choices do |t|
      t.references :question, foreign_key: true
      t.string  :choice_content, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
