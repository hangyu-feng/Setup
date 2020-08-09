# To use this profile, dot source it in $profile like this:
# . ~/setup/configs/powershell/Microsoft.PowerShell_profile.ps1

Import-Module posh-git
Import-Module oh-my-posh

Set-Theme Agnoster  # More themes at https://github.com/JanDeDobbeleer/oh-my-posh#themes

Set-PSReadLineOption -Colors @{
  Parameter = 'Cyan'  # parameters were unreadable for Nord colorscheme
  Operator = 'Cyan'
}

. $PSScriptRoot/scripts/git_alias.ps1

# Some other aliases
function scst { scoop update; scoop status }

function rename-ext {
  $ext = $args[0]
  $offset = $args[1]
  foreach ($file in (ls *.$ext)) {
    Rename-Item -Path $file -NewName $file.Name.SubString($offset)
  }
}

Set-Alias -Name vi -Value vim

$desktop = "~/OneDrive/桌面"
