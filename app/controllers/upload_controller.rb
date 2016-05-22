class UploadController < ApplicationController
  def new
  	
  end
  def create
      @upload = CsvUploadFile.new(upload_params)
      
      if @upload.save
        
         redirect_to upload_path, notice: "The file #{@upload.name} has been uploaded."
      else
        flash.now[:danger]="Upload failed"
         #redirect_to upload_path
         render 'new'
      end
      
   end

   private
      def upload_params
      	params.require(:upload).permit(:name, :attachment)
   	  end
end
