class Project < ActiveRecord::Base
  has_and_belongs_to_many :people
  has_and_belongs_to_many :events
  has_and_belongs_to_many :organizations
  validates_presence_of :name, :description
end
