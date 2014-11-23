class Project < ActiveRecord::Base
  acts_as_commentable
  has_and_belongs_to_many :people

  validates_presence_of :name, :description
end
