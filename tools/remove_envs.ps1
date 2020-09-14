write-host "Removing environment variables" -ForegroundColor Blue
Uninstall-ChocolateyEnvironmentVariable "EMSDK" -VariableType User
Uninstall-ChocolateyEnvironmentVariable "EMSDK_NODE" -VariableType User
Uninstall-ChocolateyEnvironmentVariable "JAVA_HOME" -VariableType User
Uninstall-ChocolateyEnvironmentVariable "EMSDK_PYTHON" -VariableType User
Uninstall-ChocolateyEnvironmentVariable "EM_CACHE" -VariableType User
# if added by emsdk itself it will be Machine
Uninstall-ChocolateyEnvironmentVariable "EMSDK" -VariableType Machine
Uninstall-ChocolateyEnvironmentVariable "EMSDK_NODE" -VariableType Machine
Uninstall-ChocolateyEnvironmentVariable "JAVA_HOME" -VariableType Machine
Uninstall-ChocolateyEnvironmentVariable "EMSDK_PYTHON" -VariableType Machine
Uninstall-ChocolateyEnvironmentVariable "EM_CACHE" -VariableType Machine
