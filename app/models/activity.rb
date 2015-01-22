class Activity < ActiveRecord::Base
	mount_uploader :activity_img, ImageUploader
	mount_uploader :speaker_img, ImageUploader
    belongs_to :program
    acts_as_taggable

	def self.search(tag)
		tagged_with(tag)
	end
end
