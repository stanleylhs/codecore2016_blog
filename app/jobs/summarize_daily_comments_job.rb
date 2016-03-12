class SummarizeDailyCommentsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Don't do use .all.each
    # find_in_batches
    User.find_each do |user|
      CommentMailer.send_daily_comments_summary(user).deliver_later
    end
  end
end
