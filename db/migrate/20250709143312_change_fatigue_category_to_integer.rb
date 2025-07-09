class ChangeFatigueCategoryToInteger < ActiveRecord::Migration[7.2]
  # questions(テーブル名),:fatigue_category(カラム名), :integer(新しく変更したいデータ型),
  def change    
    change_column :questions, :fatigue_category, :integer
  end
end
