# To use this profile, dot source it in $profile like this:
# . ~/setup/configs/powershell/Microsoft.PowerShell_profile.ps1

Import-Module posh-git
Import-Module oh-my-posh

Set-Theme Agnoster  # More themes at https://github.com/JanDeDobbeleer/oh-my-posh#themes

. $PSScriptRoot/scripts/git_alias.ps1

# Some other aliases
function reload { . ${profile} }
function scst { scoop update && scoop status }
