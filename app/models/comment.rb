class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  def self.current
    where.not(deleted: true)
  end

  def has_person?
    user.try!(:person).try!(:present?)
  end

  def name
    user.person.name if has_person?
  end

  def markdown
    $markdown_renderer.render(comment)
  end
end
