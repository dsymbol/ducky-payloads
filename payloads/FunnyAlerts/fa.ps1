function Invoke-ToolTip {
    param (
        $message
    )
    Add-Type -AssemblyName System.Windows.Forms
    $balloon = New-Object System.Windows.Forms.NotifyIcon
    $balloon.icon = [System.Drawing.SystemIcons]::Information
    $balloon.visible = $true
    $balloon.showballoontip(10000, '', $message, [System.Windows.Forms.ToolTipIcon]::Info)
    $balloon.Dispose()
}

# Replace messages below if you'd like
$messages = @(
    "You have won a free vacation!",
    "You have been selected for a special offer!",
    "Congratulations, you have been chosen to participate in a secret survey!",
    "Attention, your account has been flagged for suspicious activity!",
    "Warning, your computer has been infected with a virus!",
    "You have won a free car!",
    "Congratulations, you have been selected to receive a free gift card!",
    "Attention, you have been selected to receive a free subscription!",
    "Warning, your personal information has been compromised!",
    "You have been selected to receive a free trial of our premium service!",
    "Congratulations, you have been chosen to receive a free membership!",
    "Attention, your bank account has been hacked!",
    "Congratulations, you have been selected to receive a free upgrade!",
    "Warning, your email has been used to send spam!",
    "You have been selected to receive a free trial of our new product!"
)

while (1) {
    $randomMessage = Get-Random -InputObject $messages
    Invoke-ToolTip -message $randomMessage
    Sleep -Seconds 900
}