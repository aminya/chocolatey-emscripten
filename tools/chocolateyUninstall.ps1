# Based on the official installation guide: https://emscripten.org/docs/getting_started/downloads.html#uninstalling-the-emscripten-sdk

$ErrorActionPreference = 'Stop';

$installDir=$env:LOCALAPPDATA

$toolsDir="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
if (!$toolsDir) {
    $toolsDir = "$env:ChocolateyInstall\lib\emscripten\tools"
}

write-host "Uninstalling emscripten will remove $installDir\emsdk. Are you sure you want to proceed?" -ForegroundColor Yellow
$reply = Read-Host -Prompt "[y/n]"
if(!$reply) {
    $reply = "y"
}
if ( $reply -match "[yY]" ) {
    # Remove the repository
    write-host "Removing $installDir\emsdk" -ForegroundColor Blue
    if (Test-Path "$installDir\emsdk") { rm -Recurse -Force "$installDir\emsdk" }

    # Remove environment variables
    & "$toolsDir\remove_envs.ps1"
}
