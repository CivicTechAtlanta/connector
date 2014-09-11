class Organization < ActiveRecord::Base
  has_and_belongs_to_many :people
  has_and_belongs_to_many :projects
  validates_presence_of :name, :description
end
