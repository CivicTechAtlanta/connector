class Person < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_one :user

  validates_presence_of :name, :email
end
