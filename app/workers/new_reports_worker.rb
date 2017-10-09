class NewReportsWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, failure: true

  def perform(start_date, end_date, recipient_email)
    report = build_report(start_date, end_date)

    ReportsMailer.new_report_by_author(report, recipient_email, start_date, end_date).deliver
  end

  private

  def build_report(start_date, end_date)
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
    new_hash.to_h
  end
end
