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
.\emsdk.bat update-tags

# Fetch the latest registry of available tools.
.\emsdk.bat update

# Download and install the $version SDK tools.
write-host "Installing emsdk $version" -ForegroundColor Blue
.\emsdk.bat install $version --global

# Remove environment variables
& "$toolsDir\remove_envs.ps1"

# Make the $version SDK "active" for the current user. (writes ~/.emscripten file)
write-host "Activating emsdk $version" -ForegroundColor Blue
write-host "emsdk sometimes fails to add the environment variables! Ignore the failure messages about environment variables or import Python Windows extensions. Chocolatey will handle it. :)" -ForegroundColor Yellow
$emsdk_activate_output=(.\emsdk.ps1 activate $version --global 2>&1)

write-host $emsdk_activate_output -ForegroundColor DarkGray

# Make the environment variables premenant
& "$toolsDir\add_envs.ps1"

# Put the paths on PATH
& "$toolsDir\add_paths.ps1"

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
