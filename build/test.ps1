# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

<#
    .SYNOPSIS
        Test: Run unit tests for given packages/environments
#>

param (
  [string] $PackageName,
  [string] $CondaEnvironmentSuffix
)

& (Join-Path $PSScriptRoot "set-env.ps1");

Import-Module (Join-Path $PSScriptRoot "package-utils.psm1");

if ($Env:ENABLE_PYTHON -eq "false") {
  Write-Host "##vso[task.logissue type=warning;]Skipping testing Python packages. Env:ENABLE_PYTHON was set to 'false'."
} else {
  $PackageNames = PackagesList -PackageName $PackageName
  foreach ($PackageName in $PackageNames) {
    $EnvName = ($PackageName + $CondaEnvironmentSuffix).replace("-", "")
    Invoke-Tests -PackageName $PackageName -EnvName $EnvName
  }
}
