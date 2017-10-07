class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 100 }

  scope :recent, -> { order(published_at: :desc) }
end
