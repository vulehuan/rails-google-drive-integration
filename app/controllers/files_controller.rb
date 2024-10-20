class FilesController < ApplicationController
  before_action :set_google_drive_service

  def index
    @files = @google_drive_service.list_files
  rescue => e
    handle_error(e)
    @files = []
  end

  def download
    file = @google_drive_service.download_file(params[:id])
    send_data file[:content], filename: file[:file_name], type: file[:mime_type], disposition: "attachment"
  rescue => e
    handle_error(e)
    redirect_to files_path
  end

  def destroy
    @google_drive_service.delete_file(params[:id])
    flash[:notice] = "Deleted successfully!"
  rescue => e
    handle_error(e)
  ensure
    redirect_to files_path
  end

  def upload
    uploaded_file = params[:file]

    if uploaded_file
      file_path = uploaded_file.tempfile.path
      file_name = uploaded_file.original_filename
      mime_type = uploaded_file.content_type

      file_id = @google_drive_service.upload_file(file_path, file_name, mime_type)
      if file_id
        flash[:notice] = "File uploaded successfully! File ID: #{file_id}"
      else
        flash[:alert] = "Failed to upload file."
      end
    else
      flash[:alert] = "No file selected for upload."
    end
  rescue => e
    flash[:alert] = "Error: #{e.message}"
  ensure
    redirect_to files_path
  end

  private

  def set_google_drive_service
    @google_drive_service = GoogleDriveService.new
  end

  def handle_error(error)
    flash[:alert] = "Error: #{error.message}"
    Rails.logger.error("Google Drive error: #{error.message}")
  end
end
