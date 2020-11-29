# Based on the official installation guide: https://emscripten.org/docs/getting_started/downloads.html#updating-the-sdk

## Handle version
if ($env:chocolateyPackageVersion) {
    # in choco
    $version=$env:chocolateyPackageVersion
}
# to allow running without choco
elseif ($env:emsdkVersion) {
    $version=$env:emsdkVersion
}
elseif ($emsdkVersion) {
    $version=$emsdkVersion
}
else {
    $version='latest'
}

$installDir=$env:LOCALAPPDATA

$toolsDir="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
if (!$toolsDir) {
    if ($env:ChocolateyInstall) {
        $toolsDir = "$env:ChocolateyInstall\lib\emscripten\tools"
    } else {
        $toolsDir = $PSScriptRoot
    }
}

# Current path
$cwd=(Get-Location).Path

try
{
write-host "Updating https://github.com/emscripten-core/emsdk.git" -ForegroundColor Blue

# Enter that directory
cd "$installDir\emsdk"
write-host "The current working directory is changed to $installDir\emsdk" -ForegroundColor Blue

# Update the tags for emsdk
git pull
.\emsdk.ps1 update-tags

# Fetch the latest registry of available tools.
.\emsdk.ps1 update

# Download and install the $version SDK tools.
write-host "Installing emsdk $version" -ForegroundColor Blue
.\emsdk.ps1 install $version --permanent

# Remove environment variables
& "$toolsDir\remove_envs.ps1"

# Make the $version SDK "active" for the current user. (writes ~/.emscripten file)
write-host "Activating emsdk $version" -ForegroundColor Blue
$emsdk_activate_output=(.\emsdk.ps1 activate $version --permanent 2>&1)

write-host $emsdk_activate_output -ForegroundColor DarkGray

write-host "The package is successfully upgraded to the $version version in $installDir\emsdk"  -ForegroundColor Green

}
catch
{
Write-Host "Error Message: [$($_.Exception.Message)"] -ForegroundColor Red
}
finally
{

# return back to cwd
cd $cwd
write-host "The current working directory is recovered to $cwd" -ForegroundColor Blue

}
