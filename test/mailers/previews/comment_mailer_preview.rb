class CommentMailerPreview < ActionMailer::Preview
  def notification_email
    CommentMailer.notification_email(Project.first, Comment.all, Person.first)
  end
end
