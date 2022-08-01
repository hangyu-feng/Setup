function rdoRuleName() {
  return "{120D4611-E0F8-4F4E-982A-B96EC79EA66D}"
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
    Default { Write-Output "Usage: rdo help|status|solo|enable|disable|suspend" }
  }
}
