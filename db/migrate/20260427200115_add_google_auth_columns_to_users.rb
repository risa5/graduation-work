class AddGoogleAuthColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :provider_uid, :string
    add_column :users, :provider_image, :string

    add_index :users, [:provider, :provider_uidgit status], unique: true
  end
end
