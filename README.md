# YouTube Video Downloader Powershell Script
This is a script for use with windows powershell that can download youtube videos for free.

# I. Requirements
- Windows 10/11
- Windows Powershell (Should Be Installed By Default, If You Do Not Have Powershell, Download It By [Following The Guide From Microsoft](https://learn.microsoft.com/en-ca/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5#install-powershell-using-winget-recommended))
- The Latest Version of [yt-dlp for Windows (Download "yt-dlp.exe")](https://github.com/yt-dlp/yt-dlp/releases/latest)
    - Make Sure To Download **ALL** The Dependencies For yt-dlp

# II. Where To Download
Download It From The [Latest Release](https://github.com/transfem-emilia/youtube-downloader-script/releases/latest)

# III. Installation and Setup
1. Place The Powershell Script Wherever You'd Like To Place It
2. Place `yt-dlp.exe` Wherever You'd Like To Place It
3. Right Click The Script and Click `Edit In Notepad`
4. Go To Line 73, It Contains The Following Text `$ytDlpPath = "C:\Path\To\yt-dlp.exe" # Update this!`
5. Replace `C:\Path\To\yt-dlp.exe` With The Correct Directory For `yt-dlp.exe`

# IV. Using The Script
1. Right Click and Click "Run In Powershell"

    a. Alternatively, You Can Use A Batch Script To Run It Easier (See [Using A Batch Script](https://github.com/transfem-emilia/youtube-downloader-script/blob/main/batch-script/Using-A-Batch-Script.md))
2. A Window Will Open Asking For The URL, Paste The URL
3. Click  `OK`
4. The Window Will Show A Progress Bar, When The Window Closes, That Means Your Video Is Downloaded, Videos Are Downloaded To The `Downloaded Videos` Folder In `C:\Users\your-user\Videos\`