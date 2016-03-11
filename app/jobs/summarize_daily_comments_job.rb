class SummarizeDailyCommentsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Don't do use .all.each
    # find_in_batches
    User.find_each do |user|
      CommentMail.send_daily_comments_summary(user)
    end
  end
end
