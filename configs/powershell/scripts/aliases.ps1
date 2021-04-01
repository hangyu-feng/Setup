
# Some other aliases
function scst { scoop update; scoop status }

function rename-ext {
  $ext = $args[0]
  $offset = $args[1]
  foreach ($file in (Get-ChildItem *.$ext)) {
    Rename-Item -Path $file -NewName $file.Name.SubString($offset)
  }
}

Set-Alias -Name vi -Value vim

Set-Alias -Name python3 -Value python

Set-Alias -Name python2 -Value "C:\Python27\python.exe"
Set-Alias -Name py2 -Value "C:\Python27\python.exe"

function ffmpeg-download($url, $outpath) {
  ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i $url -c copy $outpath
}
