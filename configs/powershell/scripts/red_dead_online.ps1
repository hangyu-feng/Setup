function rdoRuleName() {
  return "red_dead_online_port_blocking"
}

function rdoCreateFirewallRule(){
  # port 6672 (local and remote) appears to be Social Club or the friends list.
  # Consider blocking it too: "6672, 10000-65535"
  # check https://www.reddit.com/r/RedDeadOnline/comments/gesgub/since_rdo_is_still_broken_and_ridden_with/
  $rulename = $(rdoRuleName)
  New-NetFirewallRule `
    -DisplayName "Red Dead Online Port Blocking" `
    -Name "${rulename}" `
    -Program 'D:/SteamLibrary/steamapps/common/Red Dead Redemption 2/RDR2.exe' `
    -Protocol "UDP" `
    -LocalPort 6672,10000-65535 `
    -RemotePort 6672,10000-65535 `
    -Action Block
}

function rdoStatus() {
  $rulename = $(rdoRuleName)
  $rule = Get-NetFirewallRule -name ${rulename}
  if (${rule}.Enabled -eq $true) {
    Write-Output "rdo port blocking enabled."
  } else {
    Write-Output "rdo port blocking disabled."
  }
}

function rdoDisable() {
  Disable-NetFirewallRule -Name $(rdoRuleName)
  rdoStatus
}

function rdoEnable() {
  Enable-NetFirewallRule -Name $(rdoRuleName)
  rdoStatus
}

function rdoToggle() {
  $rulename = $(rdoRuleName)
  $rule = Get-NetFirewallRule -name ${rulename}

  if (${rule}.Enabled -eq $true) {
    Disable-NetFirewallRule -InputObject $rule
  } else {
    Enable-NetFirewallRule -InputObject $rule
  }
  rdoStatus
}

function rdoSuspend() {
  ${psPath} = "C:/Users/VailG/PSTools"
  ${rdoProcess} = get-process -name "RDR2"
  & "${psPath}/pssuspend.exe" ${rdoProcess}.id
  Start-Sleep -s 10
  & "${psPath}/pssuspend.exe" -r ${rdoProcess}.id
}

function rdoSolo() {
  rdoSuspend
  Start-Sleep 30
  rdoEnable
}

function rdo(${command}) {
  switch (${command}) {
    "status" { rdoStatus }
    "solo" { rdoSolo }
    "enable" { rdoEnable }
    "disable" { rdoDisable }
    "suspend" { rdoSuspend }
    "create" { rdoCreateFirewallRule }
    Default { Write-Output "Usage: rdo help|status|solo|enable|disable|suspend" }
  }
}
