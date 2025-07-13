# YouTube Video Downloader PowerShell Script

A PowerShell script for Windows that lets you download YouTube videos for free.

## Requirements

- Windows 10 or Windows 11  
- Windows PowerShell (preinstalled on most systems)  
- The latest version of **[yt-dlp.exe](https://github.com/yt-dlp/yt-dlp/releases/latest)** for Windows  
- All required dependencies for yt-dlp  

> To install PowerShell, see [Microsoft's installation guide](https://learn.microsoft.com/powershell/).

## Download

Get the latest version of the script from the **[Latest Release](https://github.com/transfem-emilia/youtube-downloader-script/releases/latest)** section of this repository.

## Installation and Setup

1. Place the PowerShell script anywhere on your computer.  
2. Place `yt-dlp.exe` wherever you’d like.  
3. Right-click the script and choose **Edit in Notepad**.  
4. Go to **line 73**. It should look like this:  
   ```powershell
   $ytDlpPath = "C:\Path\To\yt-dlp.exe" # Update this!
   ```
5. Replace the path with the actual location of `yt-dlp.exe`. For example:  
   ```powershell
   $ytDlpPath = "C:\Tools\yt-dlp.exe"
   ```

## How to Use the Script

1. Right-click the script and choose **Run in PowerShell**.  
2. When prompted, paste the URL of the YouTube video you want to download.  
3. Select **OK** to begin the download.  
4. A progress bar will appear. When the window closes, the download is complete.  

> Downloaded videos are saved to the **Downloaded Videos** folder at:  
> `C:\Users\your-user\Videos\Downloaded Videos`

### Tip: Run with a Batch File

You can use a batch script to run this script more easily. See **[Using a Batch Script](https://github.com/transfem-emilia/youtube-downloader-script/blob/main/batch-script/Using-A-Batch-Script.md)** in this repository for details.
