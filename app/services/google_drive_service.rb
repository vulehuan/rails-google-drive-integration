# frozen_string_literal: true

require "google/apis/drive_v3"

class GoogleDriveService
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE
  CREDENTIALS_PATH = Rails.root.join("config", "credentials", "google_drive_credentials.json")
  APPLICATION_NAME = "Google Drive File Manager"

  def initialize
    @drive_service = Google::Apis::DriveV3::DriveService.new
    configure_service
  end

  def list_files
    response = @drive_service.list_files(
      q: "mimeType != 'application/vnd.google-apps.folder'",
      order_by: "name",
      fields: "files(id, name, mimeType, modifiedTime, size)"
    )
    response.files
  end

  def download_file(file_id)
    file = fetch_file_metadata(file_id)
    return unless file

    stream = StringIO.new
    @drive_service.get_file(file_id, fields: "id, name, mime_type", download_dest: stream)
    { file_name: file.name, mime_type: file.mime_type, content: stream.string }
  end

  def delete_file(file_id)
    @drive_service.delete_file(file_id)
  end

  def upload_file(file_path, file_name, mime_type)
    file_metadata = Google::Apis::DriveV3::File.new(name: file_name)

    file = @drive_service.create_file(file_metadata, upload_source: file_path, content_type: mime_type)
    file.id
  end

  private

  def fetch_file_metadata(file_id)
    @drive_service.get_file(file_id, fields: "id, name, mime_type")
  end

  def configure_service
    @drive_service.client_options.application_name = APPLICATION_NAME
    @drive_service.authorization = authorize
  end

  def authorize
    raise "Credentials file not found at #{CREDENTIALS_PATH}" unless File.exist?(CREDENTIALS_PATH)

    Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(CREDENTIALS_PATH),
      scope: SCOPE
    )
  end
end
