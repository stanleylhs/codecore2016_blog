namespace :daily_tasks do
  desc "Send summary of new comments to all post owners"
  task new_comments_summary: :environment do
    SummarizeDailyCommentsJob.perform_later
  end

end
