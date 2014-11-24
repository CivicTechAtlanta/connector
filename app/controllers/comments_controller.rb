class CommentsController < ApplicationController
  def create
    if project.comments.create(comment_params.merge(user: current_user))
      redirect_to project_path(project), notice: "Comment added!"
    else
      redirect_to project_path(project), error: "Oops, we couldn't add that comment!"
    end
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  end

  def comment_params
    params.permit(:comment)
  end
end
