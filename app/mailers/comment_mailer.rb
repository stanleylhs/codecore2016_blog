class CommentMailer < ApplicationMailer
  def ,(comment)
    @comment = comment
    @post = comment.post
    @owner = @post.user
    mail(to: @owner.email, subject: "You got an comment!")
  end
end
