class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :author_id
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :author_id
    add_index :posts, :published_at
  end
end
