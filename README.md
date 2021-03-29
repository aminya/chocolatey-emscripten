# chocolatey-emscripten
 Chocolatey package for emscripten

## Install
Install chocolatey from [here](https://chocolatey.org/install) then:
```ps1
choco install emscripten
```

**Note**: The compiler is installed in "$env:LocalAppData\emsdk".

# Uninstall
```ps1
choco uninstall emscripten
```

**Note**: The compiler is removed from "$env:LocalAppData\emsdk".

# Install without chocolatey
You should have git installed. These scripts all run in PowerShell.

1) Clone this repository:
```ps1
git clone https://github.com/aminya/chocolatey-emscripten.git
cd chocolatey-emscripten\tools
```

2) run `chocolateyInstall`
```ps1
.\chocolateyInstall.ps1
```

This installs the `latest` version. If you want to install a certain version first set `emsdkVersion` environment variable and then run install:
```ps1
$emsdkVersion="2.0.16"
.\chocolateyInstall.ps1
```

# Upgrade without chocolatey

run `chocolateyUpgrade`
```ps1
.\chocolateyUpgrade.ps1
```

This upgrades to the `latest` version. If you want to upgrade to a certain version first set `emsdkVersion` environment variable and then run upgrade:
```ps1
$emsdkVersion="2.0.16"
.\chocolateyUpgrade.ps1
```

# Uninstall without chocolatey
```ps1
.\chocolateyUninstall.ps1
```
