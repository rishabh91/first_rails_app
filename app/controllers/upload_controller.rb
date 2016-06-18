class UploadController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user,   only: [:create]
  def new
  	
  end
  def create
      @upload = CsvUploadFile.new(upload_params)
      
      if @upload.save
        
         redirect_to upload_path, notice: "The file #{@upload.name} has been uploaded."
      else
        flash[:danger]="Upload failed"
         #redirect_to upload_path
         render 'new'
      end
      
   end
   def logged_in_user
    unless logged_in?
      store_location
      flash[:danger]="Please Log in to access the page !!!!"
      redirect_to login_url
    end
  end
   def correct_user
      @user = User.find(params[:id])
      flash[:danger]="You cant upload files from others profile"
      redirect_to(current_user) unless current_user?(@user)
    end

   private
      def upload_params
      	params.require(:upload).permit(:name, :attachment)
   	  end
end
