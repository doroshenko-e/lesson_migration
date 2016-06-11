class Image < ActiveRecord::Base
  attr_accessible :image_type
  belongs-to :imagable, polymorphic: true
end
