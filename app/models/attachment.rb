class Attachment < ActiveRecord::Base
	delegate :filename, to: :file

	belongs_to :question

	validates :file, presence: true
	
	mount_uploader :file, FileUploader
end
