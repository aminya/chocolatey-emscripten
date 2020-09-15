# Based on the official installation guide: https://emscripten.org/docs/getting_started/downloads.html#installation-instructions

$version=$env:chocolateyPackageVersion
if (!$version) {
    $version='latest'
}

$installDir=$env:LOCALAPPDATA

$toolsDir="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
if (!$toolsDir) {
    $toolsDir = "$env:ChocolateyInstall\lib\emscripten"
}

if ($Env:ChocolateyForce) {
    # first clean
    & "$toolsDir\chocolateyUninstall.ps1"
} else {
    if ($version -eq (Get-UninstallRegistryKey emscripten).DisplayVersion) {
        Write-Host "Version $version is already installed." -ForegroundColor Green
        return
    } elseif (Test-Path "$installDir\emsdk") {
        write-host "emscripten is already installed at $installDir\emsdk. Do you want to upgrade to the latest sdk?" -ForegroundColor Yellow
        $reply = Read-Host -Prompt "[y/n]"
        if(!$reply) {
            $reply = "y"
        }
        if ( $reply -match "[yY]" ) {
            # call the upgrade
            & "$toolsDir\chocolateyUpgrade.ps1"
            return
        }
    }
}

# Current path
$cwd=(Get-Location).Path

try
{
write-host "Cloning https://github.com/emscripten-core/emsdk.git" -ForegroundColor Blue

# clone the emsdk repo in the tools folder
cd $installDir
write-host "The current working directory is changed to $installDir" -ForegroundColor Blue
if (!(Test-Path "emsdk")) {
    git clone https://github.com/emscripten-core/emsdk.git
}

# Enter that directory
cd emsdk
write-host "The current working directory is changed to $installDir\emsdk" -ForegroundColor Blue

# Update the tags for emsdk
git pull
.\emsdk.bat update-tags

# Download and install the SDK tools.
write-host "Installing emsdk $version" -ForegroundColor Blue
.\emsdk.bat install $version --global

# Make the $version SDK "active" for the current user. (writes ~/.emscripten file)
write-host "Activating emsdk $version" -ForegroundColor Blue
write-host "emsdk sometimes fails to add the environment variables! Ignore the failure messages about environment variables or import Python Windows extensions. Chocolatey will handle it. :)" -ForegroundColor Yellow
.\emsdk.bat activate $version --global 2>&1

# Activate PATH and other environment variables in the current terminal
$emsdk_env_output=(.\emsdk_env.bat 2>&1)

# Make the environment variables premenant
& "$toolsDir\add_envs.ps1"

# Put the paths on PATH
& "$toolsDir\add_paths.ps1"

write-host "The package is successfully installed in $installDir\emsdk" -ForegroundColor Green

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
