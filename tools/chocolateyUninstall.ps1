# Based on the official installation guide: https://emscripten.org/docs/getting_started/downloads.html#uninstalling-the-emscripten-sdk

$ErrorActionPreference = 'Stop';

$installDir=$env:LOCALAPPDATA

$toolsDir="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
if (!$toolsDir) {
    if ($env:ChocolateyInstall) {
        $toolsDir = "$env:ChocolateyInstall\lib\emscripten\tools"
    } else {
        $toolsDir = $PSScriptRoot
    }
}

write-host "Uninstalling emscripten will remove $installDir\emsdk." -ForegroundColor Yellow
# Remove the repository
write-host "Removing $installDir\emsdk" -ForegroundColor Blue
if (Test-Path "$installDir\emsdk") { rm -Recurse -Force "$installDir\emsdk" }

# Remove environment variables
& "$toolsDir\remove_envs.ps1"

# Remove paths
& "$toolsDir\remove_paths.ps1"
