class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :body, :title, presence: true
end
