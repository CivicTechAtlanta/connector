class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  def has_person?
    user.try!(:person).try!(:present?)
  end

  def name
    user.person.name if has_person?
  end

  def markdown
    markdown_parser.render(comment)
  end

  private

  def markdown_parser
    @markdown_parser ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(with_toc_data: true))
  end
end
