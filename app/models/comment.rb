class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  before_create :time_now_if_published_at_is_nil

  validates :body, presence: true

  scope :comments_for_period, -> (start_date, end_date) { where(published_at: start_date..end_date) }

  private

  def time_now_if_published_at_is_nil
    unless published_at.present?
      self.published_at = Time.now
    end
  end
end
