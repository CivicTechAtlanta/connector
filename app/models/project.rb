class Project < ActiveRecord::Base
  has_and_belongs_to_many :people
  validates_presence_of :name, :description

  has_attached_file :photo, :styles => { :lg => "1024x768#", :medium => "256x192#", :thumb => "100x100#" },
                    :default_url => "default_image256x192.png",
                    :url  => "/assets/projects/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/projects/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end
