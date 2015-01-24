CommentMailerJob = Struct.new(:project, :current_person) do
  def perform
    people_to_send_to.each do |person|
      CommentMailer.notification_email(project, comments_to_send, person).deliver
    end
  end

  private

  def comments_to_send
    project.comments.order(created_at: :desc).limit(5)
  end

  def people_to_send_to
    project.people.joins(:user).where.not(people: { id: current_person.id })
  end
end
