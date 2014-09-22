class Person < ActiveRecord::Base
  has_and_belongs_to_many :projects

  def name
    "#{first_name} #{last_name}"
  end
end
