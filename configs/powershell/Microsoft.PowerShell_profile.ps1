# To use this profile, dot source it in $profile like this:
# . ~/setup/configs/powershell/Microsoft.PowerShell_profile.ps1

Import-Module posh-git
Import-Module oh-my-posh

# see https://ohmyposh.dev/

Set-PoshPrompt -Theme ~/setup/configs/powershell/themes/diu.omp.json  # More themes at https://github.com/JanDeDobbeleer/oh-my-posh#themes
# Set-PoshPrompt -Theme agnosterplus

Set-PSReadLineOption -Colors @{
  Parameter = 'Cyan'  # parameters were unreadable for Nord colorscheme
  Operator = 'Cyan'
}

. $PSScriptRoot/scripts/git_alias.ps1

. $PSScriptRoot/scripts/aliases.ps1
