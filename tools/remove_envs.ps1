write-host "Removing the environment variables (e.g. JAVA_HOME, EMSDK, etc.)" -ForegroundColor Blue
try {
  Uninstall-ChocolateyEnvironmentVariable "EMSDK" -VariableType User
  Uninstall-ChocolateyEnvironmentVariable "EMSDK_NODE" -VariableType User
  Uninstall-ChocolateyEnvironmentVariable "JAVA_HOME" -VariableType User
  Uninstall-ChocolateyEnvironmentVariable "EMSDK_PYTHON" -VariableType User
  Uninstall-ChocolateyEnvironmentVariable "EM_CACHE" -VariableType User
  Uninstall-ChocolateyEnvironmentVariable "EM_CONFIG" -VariableType User
  Uninstall-ChocolateyEnvironmentVariable "BINARYEN_ROOT" -VariableType USER
  Uninstall-ChocolateyEnvironmentVariable "EMSCRIPTEN" -VariableType USER
  Uninstall-ChocolateyEnvironmentVariable "EMSCRIPTEN_NATIVE_OPTIMIZER" -VariableType USER
  Uninstall-ChocolateyEnvironmentVariable "EMCC_WASM_BACKEND" -VariableType USER

  # if added by emsdk itself it will be Machine
  Uninstall-ChocolateyEnvironmentVariable "EMSDK" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "EMSDK_NODE" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "JAVA_HOME" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "EMSDK_PYTHON" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "EM_CACHE" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "EM_CONFIG" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "BINARYEN_ROOT" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "EMSCRIPTEN" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "EMSCRIPTEN_NATIVE_OPTIMIZER" -VariableType Machine
  Uninstall-ChocolateyEnvironmentVariable "EMCC_WASM_BACKEND" -VariableType Machine

} catch {
  [Environment]::SetEnvironmentVariable("EMSDK", $null, "User")
  [Environment]::SetEnvironmentVariable("EMSDK_NODE", $null, "User")
  [Environment]::SetEnvironmentVariable("JAVA_HOME", $null, "User")
  [Environment]::SetEnvironmentVariable("EMSDK_PYTHON", $null, "User")
  [Environment]::SetEnvironmentVariable("EM_CACHE", $null, "User")
  [Environment]::SetEnvironmentVariable("EM_CONFIG", $null, "User")
  [Environment]::SetEnvironmentVariable("BINARYEN_ROOT", $null, "User")
  [Environment]::SetEnvironmentVariable("EMSCRIPTEN", $null, "User")
  [Environment]::SetEnvironmentVariable("EMSCRIPTEN_NATIVE_OPTIMIZER", $null, "User")
  [Environment]::SetEnvironmentVariable("EMCC_WASM_BACKEND", $null, "User")

  # if added by emsdk itself it will be Machine
  [Environment]::SetEnvironmentVariable("EMSDK", $null, "Machine")
  [Environment]::SetEnvironmentVariable("EMSDK_NODE", $null, "Machine")
  [Environment]::SetEnvironmentVariable("JAVA_HOME", $null, "Machine")
  [Environment]::SetEnvironmentVariable("EMSDK_PYTHON", $null, "Machine")
  [Environment]::SetEnvironmentVariable("EM_CACHE", $null, "Machine")
  [Environment]::SetEnvironmentVariable("EM_CONFIG", $null, "Machine")
  [Environment]::SetEnvironmentVariable("BINARYEN_ROOT", $null, "Machine")
  [Environment]::SetEnvironmentVariable("EMSCRIPTEN", $null, "Machine")
  [Environment]::SetEnvironmentVariable("EMSCRIPTEN_NATIVE_OPTIMIZER", $null, "Machine")
  [Environment]::SetEnvironmentVariable("EMCC_WASM_BACKEND", $null, "Machine")

}
