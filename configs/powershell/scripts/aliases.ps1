
# Some other aliases
function scst { scoop update; scoop status }

function rename-ext {
  $ext = $args[0]
  $offset = $args[1]
  foreach ($file in (Get-ChildItem *.$ext)) {
    Rename-Item -Path $file -NewName $file.Name.SubString($offset)
  }
}

function sudo {
  Start-Process @args -verb runas
}

Set-Alias -Name vi -Value vim

Set-Alias -Name python3 -Value python
