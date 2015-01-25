class CommentMailerJob
  include SuckerPunch::Job

  def perform(project, current_person)
    ActiveRecord::Base.connection_pool.with_connection do
      @project = project
      @current_person = current_person

      people_to_send_to.each do |person|
        CommentMailer.notification_email(project, comments_to_send, person).deliver
      end
    end
  end

  private

  def comments_to_send
    @project.comments.order(created_at: :desc).limit(1)
  end

  def people_to_send_to
    @project.people.joins(:user).where.not(people: { id: @current_person.id })
  end
end
