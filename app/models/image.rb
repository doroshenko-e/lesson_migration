class Image < ActiveRecord::Base
  attr_accessible :image_type
  belongs_to :imageable, polymorphic: true
  attachment :image_file
end
