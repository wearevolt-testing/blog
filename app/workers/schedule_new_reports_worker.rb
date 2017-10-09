class ScheduleNewReportsWorker
  include Sidekiq::Worker

  def perform(start_date, end_date, recipient_email)
    json = build_json(start_date, end_date)
    NewReportsWorker.perform_async(json, recipient_email, start_date, end_date)
  end

  private

  def build_json(start_date, end_date)
    hash = {}

    User.pluck(:id, :email, :nickname).each do |user|
      posts_size = Post.where(author_id: user[0]).posts_for_period(start_date, end_date).size
      comments_size = Comment.where(author_id: user[0]).comments_for_period(start_date, end_date).size

      position = posts_size + comments_size / 10

      hash[user[0]] = {}
      hash[user[0]]['email'] = user[1]
      hash[user[0]]['nickname'] = user[2]
      hash[user[0]]['posts_size'] = posts_size
      hash[user[0]]['comments_size'] = comments_size
      hash[user[0]]['position'] = position
    end

    new_hash = hash.sort_by { |key, value| hash[key]['position'] }.reverse
    new_hash.to_json
  end
end
