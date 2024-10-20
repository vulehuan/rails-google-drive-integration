# Ruby on Rails - Google Drive Integration

This repository is a demo for managing files in Google Drive. It showcases functionalities such as listing files, uploading files, downloading files, and deleting files.

## Features

- List files from Google Drive
- Upload files to Google Drive
- Download files from Google Drive
- Delete files from Google Drive

## Setup Instructions

1. **Create a Service Account:**
    - Go to the [Google Cloud Console](https://console.cloud.google.com/).
    - Create a new service account.
    - Enable the **Google Drive API** for the service account.

2. **Download Credentials:**
    - Download the credentials JSON file and place it in the following path:
      ```
      config/credentials/google_drive_credentials.json
      ```

3. **Share Your Google Drive Folder:**
    - Share the Google Drive folder you want to manage with the service account email.

4. **Run the Application:**
    - Start the application and interact with the user interface to manage your files.

## Code Reference

For more details on how to interact with Google Drive, refer to the following file:
```
app/services/google_drive_service.rb
```

## Notes

This is a basic demo of how to interact with Google Drive. You may want to enhance the application by adding:

- **Caching**: Temporarily store responses from Google Drive to reduce the number of requests sent to the API and improve loading speed.
- **Authentication**: Integrate OAuth authentication to ensure that only logged-in users can access and interact with files in Google Drive.
- **Authorization**: Set up permissions for users, allowing only specific users to view, upload, or delete files.
- **Pagination for file listings**: Display files in pages to improve usability and manage large file lists.
- **Upload limits for files**: Define a maximum number of files that users can upload and specify allowed file types (e.g., only PDF, image, or DOC files).
- **File size restrictions**: Alert users if the file they are trying to upload exceeds the allowed maximum size.
- **Improved error handling**: Show clear error messages to users if there is an issue during file upload or retrieval.
- **File search functionality**: Add a search feature so users can easily find specific files in Google Drive.
- **File tagging**: Allow users to tag files for easier categorization and later retrieval.
- **File preview**: Provide the ability to preview files before downloading or opening them.
- **File sharing**: Integrate a file-sharing feature that allows users to share files with others and manage access permissions.

These features can enhance the user experience and create a more robust application.