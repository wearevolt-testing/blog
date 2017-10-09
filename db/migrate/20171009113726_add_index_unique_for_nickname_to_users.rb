class AddIndexUniqueForNicknameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :nickname, unique: true
  end
end
