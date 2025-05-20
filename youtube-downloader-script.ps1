Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form for URL input
$form = New-Object System.Windows.Forms.Form
$form.Text = "Download Video"
$form.Size = New-Object System.Drawing.Size(400,150)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Paste video URL:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10,20)
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Size = New-Object System.Drawing.Size(360,20)
$textBox.Location = New-Object System.Drawing.Point(10,40)
$form.Controls.Add($textBox)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK"
$okButton.Location = New-Object System.Drawing.Point(210,75)
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = "Cancel"
$cancelButton.Location = New-Object System.Drawing.Point(290,75)
$cancelButton.Add_Click({ $form.Close() })
$form.Controls.Add($cancelButton)

# Progress bar form - hidden initially
$progressForm = New-Object System.Windows.Forms.Form
$progressForm.Text = "Downloading..."
$progressForm.Size = New-Object System.Drawing.Size(400,100)
$progressForm.StartPosition = "CenterScreen"
$progressForm.Topmost = $true

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Style = 'Continuous'
$progressBar.Minimum = 0
$progressBar.Maximum = 100
$progressBar.Value = 0
$progressBar.Size = New-Object System.Drawing.Size(360,25)
$progressBar.Location = New-Object System.Drawing.Point(10,30)
$progressForm.Controls.Add($progressBar)

$progressLabel = New-Object System.Windows.Forms.Label
$progressLabel.AutoSize = $true
$progressLabel.Text = "Progress: 0%"
$progressLabel.Location = New-Object System.Drawing.Point(10,5)
$progressForm.Controls.Add($progressLabel)

# Click event handler for OK button
$okButton.Add_Click({
    $url = $textBox.Text.Trim()
    if ([string]::IsNullOrWhiteSpace($url)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a URL.")
        return
    }

    # Hide URL input form, show progress form
    $form.Hide()
    $progressForm.Show()

    $videosPath = [Environment]::GetFolderPath("MyVideos")
    $targetPath = Join-Path $videosPath "Downloaded Videos"
    if (-not (Test-Path $targetPath)) {
        New-Item -ItemType Directory -Path $targetPath | Out-Null
    }

    # Full path to yt-dlp.exe
    $ytDlpPath = "C:\Path\To\yt-dlp.exe" # Update this!

    # Build argument list with --newline for parsing progress
    $arguments = @(
        "`"$url`""
        "-f"
        "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
        "--newline"
        "--output"
        "`"$targetPath\%(title)s.%(ext)s`""
    )

    # Create a process start info object to redirect output
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $ytDlpPath
    $startInfo.Arguments = $arguments -join " "
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true
    $startInfo.WorkingDirectory = $targetPath

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo
    $process.Start() | Out-Null

    # Async read output lines and update progress bar
    $outputReader = $process.StandardOutput
    while (-not $process.HasExited) {
        while (-not $outputReader.EndOfStream) {
            $line = $outputReader.ReadLine()
            # yt-dlp outputs progress lines like: [download]  45.3% of 50.00MiB at 1.00MiB/s ETA 00:30
            if ($line -match "\[download\]\s+(\d{1,3}\.\d)%") {
                $percent = [math]::Round([double]$matches[1])
                if ($percent -ge 0 -and $percent -le 100) {
                    # Update progress bar safely on UI thread
                    $progressBar.Invoke([action]{
                        $progressBar.Value = $percent
                        $progressLabel.Text = "Progress: $percent%"
                    })
                }
            }
        }
        Start-Sleep -Milliseconds 100
    }

    # Read remaining output after process exits
    while (-not $outputReader.EndOfStream) {
        $line = $outputReader.ReadLine()
        if ($line -match "\[download\]\s+(\d{1,3}\.\d)%") {
            $percent = [math]::Round([double]$matches[1])
            $progressBar.Invoke([action]{
                $progressBar.Value = $percent
                $progressLabel.Text = "Progress: $percent%"
            })
        }
    }

    $progressLabel.Invoke([action]{ $progressLabel.Text = "Download complete! 🎉" })

    # Optional: Wait a sec before closing or allow user to close
    Start-Sleep -Seconds 3
    $progressForm.Close()
    $form.Close()
})

$form.Topmost = $true
$form.Add_Shown({ $textBox.Select() })
$form.ShowDialog()
