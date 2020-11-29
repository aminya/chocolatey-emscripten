# Based on the official installation guide: https://emscripten.org/docs/getting_started/downloads.html#installation-instructions

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

if ($Env:ChocolateyForce) {
    # first clean
    & "$toolsDir\chocolateyUninstall.ps1"
} else {
    if ($version -eq (Get-UninstallRegistryKey emscripten).DisplayVersion) {
        Write-Host "Version $version is already installed." -ForegroundColor Green
        return
    } elseif (Test-Path "$installDir\emsdk") {
        write-host "emscripten is already installed at $installDir\emsdk. The sdk will be upgraded to $version." -ForegroundColor Yellow
        # call the upgrade
        & "$toolsDir\chocolateyUpgrade.ps1"
        return
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
.\emsdk.ps1 update-tags

# Download and install the SDK tools.
write-host "Installing emsdk $version" -ForegroundColor Blue
.\emsdk.ps1 install $version --permanent

# Make the $version SDK "active" for the current user. (writes ~/.emscripten file)
write-host "Activating emsdk $version" -ForegroundColor Blue
$emsdk_activate_output=(.\emsdk.ps1 activate $version --permanent 2>&1)

write-host $emsdk_activate_output -ForegroundColor DarkGray

write-host "The installation added the emsdk's bundled Python, Node, and Java to the PATH." -ForegroundColor Blue
write-host "and it set JAVA_HOME to the path of the bundled Java." -ForegroundColor Blue
write-host "If this conflicts with your other development environments, remove these from PATH." -ForegroundColor Blue

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
