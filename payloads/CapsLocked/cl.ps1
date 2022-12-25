Add-Type -AssemblyName System.Windows.Forms

function Toggle-CapsLock {
    param (
        $WshShell
    )

    if (([System.Windows.Forms.Control]::IsKeyLocked('CapsLock')) -eq $false) {
        $WshShell.SendKeys('{CAPSLOCK}')
    }
}

function Check-CapsLock {
    $signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode);
'@
    $API = Add-Type -MemberDefinition $signature -Name 'Keypress' -Namespace API -PassThru
    if ($API::GetAsyncKeyState(20) -eq -32767) {
        return $true
    }
    else {
        return $false
    }
}

try {
    $WshShell = New-Object -ComObject wscript.shell
}
catch {
    Write-Error "Could not create the wscript.shell COM object: $($_.Exception.Message)"
    return
}

Toggle-CapsLock -WshShell $WshShell

while (1) {
    do {
        Start-Sleep -Milliseconds 40
    } until (Check-CapsLock)

    Start-Sleep -Milliseconds 250

    Toggle-CapsLock -WshShell $WshShell
}
