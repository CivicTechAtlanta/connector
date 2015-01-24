class CommentMailer < ActionMailer::Base
  default from: "notifications@codeforatlanta.org"

  def notification_email(project, comments_to_send, person)
    @project = project
    @comments = comments_to_send
    @person = person

    mail(to: @person.user.email, subject: "Code for Atlanta Connector - New Comment: #{@project.name}")
  end
end
