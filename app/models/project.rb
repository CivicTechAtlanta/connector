class Project < ActiveRecord::Base
  URL_TYPES = ["Code Repository", "Website"]
  class UrlsValidator < ActiveModel::Validator
    def validate(record)
      record.urls.each do |type, url|
        unless URL_TYPES.include?(type)
          record.errors[:base] = "#{type} is not a valid URL type"
        end
      end
    end
  end

  acts_as_commentable
  acts_as_taggable
  has_and_belongs_to_many :people

  validates_presence_of :name, :description
  validates_with UrlsValidator

  def urls
    super || []
  end
end
