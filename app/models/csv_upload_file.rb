class CsvUploadFile < ActiveRecord::Base
	 mount_uploader :attachment, AttachmentUploader
	 validates :name, presence: true,length: {maximum: 12 }

	
end
