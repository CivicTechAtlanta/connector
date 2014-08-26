class Person < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :events
  has_and_belongs_to_many :organizations

  def name
    "#{first_name} #{last_name}"
  end
end