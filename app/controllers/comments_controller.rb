class CommentsController < ApplicationController
  def create
    return head :forbidden unless validate_humanity(params)

    if project.comments.create(comment_params.merge(user: current_user))
      notify_project
      redirect_to project_path(project), notice: 'Comment added!'
    else
      redirect_to project_path(project), error: 'Oops, we couldn\'t add that comment!'
    end
  end

  private

  def validate_humanity(params)
    params['imahuman'].to_s == ENV['IMAHUMAN'].to_s && verify_recaptcha(params)
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def comment_params
    params.permit(:comment)
  end

  def notify_project
    CommentMailerJob.perform_async(project, current_person)
  end
end
