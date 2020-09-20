# Make the environment variables premenant
write-host "Handling possible emsdk's failures to set environment variables" -ForegroundColor Blue

# Manual Method
# the emsdk script sometimes does not add the variables!
# Install-ChocolateyEnvironmentVariable "EMSDK" $EMSDK -VariableType User
# Install-ChocolateyEnvironmentVariable "EMSDK_NODE" $EMSDK_NODE -VariableType User
# Install-ChocolateyEnvironmentVariable "JAVA_HOME" $JAVA_HOME -VariableType User
# Install-ChocolateyEnvironmentVariable "EMSDK_PYTHON" $EMSDK_PYTHON -VariableType User
# Install-ChocolateyEnvironmentVariable "EM_CACHE" $EM_CACHE -VariableType User

# Parse emsdk_activate_output

$envs_names_to_add=($emsdk_activate_output | Select-String "(.*) = (.*)" -AllMatches | %{$_.matches} | %{$_.groups})

# loop over each group (e.g if length == 18 -> 1,2; 4,5; ... ;16,17)
For ($i=1; $i -le ($envs_names_to_add.length-2); $i = $i+3) {
    $env_name = $envs_names_to_add[$i]
    $env_value = $envs_names_to_add[$i+1]
    write-host "Adding $env_name to the permanent environment variables" -ForegroundColor Blue
    try {
        Install-ChocolateyEnvironmentVariable $env_name  $env_value -VariableType User
    } catch {
        [Environment]::SetEnvironmentVariable($env_name , $env_value, "User")
    }
}
