class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  def has_person?
    user.try!(:person).try!(:present?)
  end

  def name
    user.person.name if has_person?
  end

  def markdown
    markdown_parser.render comment
  end

  private
  # TODO should probably be shared with multiple models. I'm not sure the rails-iest way to do this
  def markdown_parser
    @parser ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(with_toc_data: true))
  end
end
