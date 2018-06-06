[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$SolutionName    
)

if(!$PSScriptRoot){
    $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}

$RootPath = $PSScriptRoot
$SolutionNameKey = "#Solution#"
$GitDir = Join-Path $RootPath ".git"
$SrcKeep = Join-Path $RootPath "src\.gitkeep"
$TestKeep = Join-Path $RootPath "test\.gitkeep"
$SolutionFile = Join-Path $RootPath "Solution.sln"
$DotSettingsFile = Join-Path $RootPath "Solution.sln.DotSettings"
$RulesetFile = Join-Path $RootPath "Solution.ruleset"
$CommonPropsFile = Join-Path $RootPath "build\common.props"
$ReadMe = Join-Path $RootPath "README.md"
$InitScript = Join-Path (Get-Item $MyInvocation.MyCommand.Path).DirectoryName "run.ps1"

Remove-Item $GitDir -Force -Recurse -ErrorAction SilentlyContinue
Write-Host "Removed $GitDir"

(Get-Content $SolutionFile).replace($SolutionNameKey, $SolutionName) | Set-Content $SolutionFile
Write-Host "Updated $($SolutionFile).sln"

Rename-Item $SolutionFile "$($SolutionName).sln"
Write-Host "Renamed $SolutionFile to $($SolutionName).sln"

(Get-Content $DotSettingsFile).replace($SolutionNameKey, $SolutionName) | Set-Content $DotSettingsFile
Write-Host "Updated $($DotSettingsFile).sln.DotSettings"

Rename-Item $DotSettingsFile "$($SolutionName).sln.DotSettings"
Write-Host "Renamed $DotSettingsFile to $($SolutionName).sln.DotSettings"

Rename-Item $RulesetFile "$($SolutionName).ruleset"
Write-Host "Renamed $RulesetFile to $($SolutionName).ruleset"

(Get-Content $CommonPropsFile).replace($SolutionNameKey, $SolutionName) | Set-Content $CommonPropsFile
Write-Host "Updated common.props"

"# $($SolutionName) Documentation" | Out-File $ReadMe
Write-Host "Updated README with Solution Name"

Remove-Item $SrcKeep -Force -Recurse
Remove-Item $TestKeep -Force -Recurse
Write-Host "Removed .gitkeep files"

Remove-Item $InitScript -Force -Recurse
Write-Host "Removed run.ps1"
