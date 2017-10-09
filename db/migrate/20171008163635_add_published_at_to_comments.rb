class AddPublishedAtToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :published_at, :datetime
    add_index  :comments, :published_at
  end
end
