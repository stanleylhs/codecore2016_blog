class CommentMailer < ApplicationMailer
  def notify_post_owner(comment)
    @comment = comment
    @post = comment.post
    @owner = @post.user
    mail(to: @owner.email, subject: "You got an comment!")
  end

  def send_daily_comments_summary(user)
    @owner = user
    @posts = user.posts.with_new_comments
    mail(to: @owner.email, subject: "A Summary of New Comments for @post.title")
  end
end
