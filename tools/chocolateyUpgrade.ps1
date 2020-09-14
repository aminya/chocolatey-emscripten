# Based on the official installation guide: https://emscripten.org/docs/getting_started/downloads.html#updating-the-sdk

$installDir=$env:LOCALAPPDATA

$toolsDir="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
if (!$toolsDir) {
    $toolsDir = "$env:ChocolateyInstall\lib\emscripten"
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

# Download and install the latest SDK tools.
write-host "Installing emsdk latest" -ForegroundColor Blue
.\emsdk.bat install latest --global

# Remove environment variables
& "$toolsDir\remove_envs.ps1"

# Make the latest SDK "active" for the current user. (writes ~/.emscripten file)
write-host "Activating emsdk latest" -ForegroundColor Blue
write-host "emsdk sometimes fails to add the environment variables! Ignore the failure messages about environment variables or import Python Windows extensions. Chocolatey will handle it. :)" -ForegroundColor Yellow
.\emsdk.bat activate latest --global 2>&1

# Activate PATH and other environment variables in the current terminal
$emsdk_env_output=(.\emsdk_env.bat 2>&1)

# Make the environment variables premenant
& "$toolsDir\add_envs.ps1"

# Put the paths on PATH
& "$toolsDir\add_paths.ps1"

write-host "The package is successfully upgraded to the latest version in $installDir\emsdk"  -ForegroundColor Green

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
