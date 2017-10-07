class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 100 }

  scope :recent, -> { order(published_at: :desc) }

  before_create :time_now_if_published_at_is_nil

  private

  def time_now_if_published_at_is_nil
    unless published_at.present?
      self.published_at = Time.now
    end
  end
end
