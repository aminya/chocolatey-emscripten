# Put the paths on PATH
write-host "Handling possible emsdk's failures to set paths" -ForegroundColor Blue
write-host "Putting emsdk, emscripten, emsdk_node, emsdk_java, and emsdk_python on the PATH" -ForegroundColor Blue

# Manual method
# does not put the upstream or fastcomp emscripten on the path
# $_emsdk_path="$installDir\emsdk"
# $_emsdk_node_path=([System.IO.Path]::GetDirectoryName($EMSDK_NODE))
# $_emsdk_java_path="$JAVA_HOME\bin"
# $_emsdk_python_path=$EMSDK_PYTHON
#
# Install-ChocolateyPath -PathToInstall $_emsdk_path -PathType User
# Install-ChocolateyPath -PathToInstall $_emsdk_node_path -PathType User
# Install-ChocolateyPath -PathToInstall $_emsdk_java_path -PathType User
# Install-ChocolateyPath -PathToInstall $_emsdk_python_path -PathType User

# Parse emsdk_activate_output

$paths_to_add=($emsdk_activate_output | Select-String "^(?:PATH \+\= )(.*)$" -AllMatches | %{$_.matches} | %{$_.Value}) -replace "PATH \+\= ", ""

Foreach ($path_to_add in $paths_to_add) {
    try {
        Install-ChocolateyPath -PathToInstall $path_to_add -PathType User
    } catch {
        [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$path_to_add", "User")
    }
}
