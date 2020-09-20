$installDir=$env:LocalAppData
$emsdk_path="$installDir\emsdk"
$emsdk_path_regex = [regex]::escape($emsdk_path)

write-host "Removing emscripten from PATH" -ForegroundColor Blue

try {
  # User
  $envPath =  [Environment]::GetEnvironmentVariable("PATH", "User")
  $newPath = $envPath -replace ($emsdk_path_regex+"[^;]*;"), "" -replace ($emsdk_path_regex+"[^;]*;?$"), ""
  [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")

  # Machine
  $envPath =  [Environment]::GetEnvironmentVariable("PATH", "Machine")
  $newPath = $envPath -replace ($emsdk_path_regex+"[^;]*;"), "" -replace ($emsdk_path_regex+"[^;]*;?$"), ""
  [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")

} catch {
  Write-Host "Error Message: [$($_.Exception.Message)"] -ForegroundColor Red
}
