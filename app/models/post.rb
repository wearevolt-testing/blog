class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :comments, as: :commentable

  before_create :time_now_if_published_at_is_nil

  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 100 }

  scope :recent,           -> { order(published_at: :desc) }
  scope :posts_for_period, ->(start_date, end_date) { where(published_at: start_date..end_date) }

  private

  def time_now_if_published_at_is_nil
    return false if published_at.present?

    self.published_at = Time.now
  end
end
