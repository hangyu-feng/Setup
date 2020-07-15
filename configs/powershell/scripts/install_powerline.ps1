# Using PowerShell, install Posh-Git and Oh-My-Posh.
# Posh-Git adds Git status information to your prompt as well as tab-completion
# for Git commands, parameters, remotes, and branch names. Oh-My-Posh provides
# theme capabilities for your PowerShell prompt.
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

# If you are using PowerShell Core, install PSReadline.
# PSReadline lets you customize the command line editing environment in PowerShell.
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

# Here I installed both posh-git and PSReadline because there is nothing wrong.

. $profile
