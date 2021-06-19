
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

function ffmpeg-download($url, $origin, $referer, $outpath) {
  $userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101 Firefox/87.0"
  ffmpeg -user_agent $userAgent -headers "origin:${origin}" -headers "referer:${referer}" -protocol_whitelist file,http,https,tcp,tls,crypto -i $url -c copy $outpath
}

function networth($buyback) {
  ($buyback - 200) * 13
}

function nvenc($inputPath, $outPath) {
  ffmpeg -i $inputPath -vcodec hevc_nvenc $outPath
}
