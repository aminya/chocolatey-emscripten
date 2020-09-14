# Based on the official installation guide: https://emscripten.org/docs/getting_started/downloads.html#uninstalling-the-emscripten-sdk

$ErrorActionPreference = 'Stop';

$installDir=$env:LOCALAPPDATA

write-host "Uninstalling emscripten will remove $installDir\emsdk. Are you sure you want to proceed?" -ForegroundColor Yellow
$reply = Read-Host -Prompt "[y/n]"
if ( $reply -match "[yY]" ) {
    # Remove the repository
    write-host "Removing $installDir\emsdk" -ForegroundColor Blue
    if (Test-Path "$installDir\emsdk") { rm -Recurse -Force "$installDir\emsdk" }

    # Remove environment variables
    write-host "Removing environment variables" -ForegroundColor Blue
    Uninstall-ChocolateyEnvironmentVariable "EMSDK" -VariableType User
    Uninstall-ChocolateyEnvironmentVariable "EMSDK_NODE" -VariableType User
    Uninstall-ChocolateyEnvironmentVariable "JAVA_HOME" -VariableType User
    Uninstall-ChocolateyEnvironmentVariable "EMSDK_PYTHON" -VariableType User
    Uninstall-ChocolateyEnvironmentVariable "EM_CACHE" -VariableType User
}
