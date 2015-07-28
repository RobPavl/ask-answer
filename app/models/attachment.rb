class Attachment < ActiveRecord::Base
	delegate :identifier, to: :file

	belongs_to :attachable, polymorphic: true

	validates :file, presence: true
	
	mount_uploader :file, FileUploader
end
