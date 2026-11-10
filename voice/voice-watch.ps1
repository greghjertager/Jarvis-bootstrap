# Jarvis voice watch (Windows): while this window is open, any new text in speak.txt is spoken aloud.
# The AI writes a spoken version of each reply to speak.txt; this script reads it with a voice built into Windows.
# Close the window to turn voice off. Writes no files. Optional pronunciation fixes go in pronounce.txt.
# Pick the voice: run "List Jarvis Voices.bat" and set $VoiceName to part of a voice's name (for example 'George' or 'Hazel').
param([string]$VoiceName = 'George', [string]$Greeting = 'Voice is on.')
$ErrorActionPreference = 'Stop'
$file = Join-Path $PSScriptRoot 'speak.txt'
try {
  Add-Type -AssemblyName System.Runtime.WindowsRuntime
  $asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object {
    $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
  [Windows.Media.SpeechSynthesis.SpeechSynthesizer,Windows.Media.SpeechSynthesis,ContentType=WindowsRuntime] | Out-Null
  $voice = [Windows.Media.SpeechSynthesis.SpeechSynthesizer]::AllVoices | Where-Object { $_.DisplayName -like "*$VoiceName*" } | Select-Object -First 1
  if (-not $voice) { throw "No installed voice matches '$VoiceName'. Run List Jarvis Voices.bat to see what is installed." }
  $synth = New-Object Windows.Media.SpeechSynthesis.SpeechSynthesizer
  $synth.Voice = $voice
  try { $synth.Options.SpeakingRate = 0.95 } catch { }
} catch {
  Write-Host "Jarvis: voice setup failed. $_"
  Write-Host $_.ScriptStackTrace
  exit 1
}
function Say([string]$text) {
  $op = $synth.SynthesizeTextToStreamAsync($text)
  $task = $asTaskGeneric.MakeGenericMethod([Windows.Media.SpeechSynthesis.SpeechSynthesisStream]).Invoke($null, @($op))
  $task.Wait(-1) | Out-Null
  $in = [System.IO.WindowsRuntimeStreamExtensions]::AsStreamForRead($task.Result)
  $ms = New-Object System.IO.MemoryStream
  $in.CopyTo($ms); $in.Close(); $ms.Position = 0
  (New-Object System.Media.SoundPlayer $ms).PlaySync()
  $ms.Close()
}
Write-Host "Jarvis voice is ON ($($voice.DisplayName)). Watching $file"
Write-Host "Leave this window open. Close it to turn voice off."
Say $Greeting
$last = if (Test-Path $file) { (Get-Item $file).LastWriteTimeUtc } else { [datetime]::MinValue }
while ($true) {
  Start-Sleep -Milliseconds 700
  try {
    if (-not (Test-Path $file)) { continue }
    $now = (Get-Item $file).LastWriteTimeUtc
    if ($now -ne $last) {
      Start-Sleep -Milliseconds 300
      $last = (Get-Item $file).LastWriteTimeUtc
      $text = (Get-Content $file -Raw -Encoding UTF8)
      if ($text -and $text.Trim()) {
        $dict = Join-Path $PSScriptRoot 'pronounce.txt'
        if (Test-Path $dict) { Get-Content $dict -Encoding UTF8 | Where-Object { $_ -match '^[^#].*=' } | ForEach-Object {
          $k, $v = $_ -split '=', 2; $text = [regex]::Replace($text, '\b' + [regex]::Escape($k.Trim()) + '\b', $v.Trim(), 'IgnoreCase') } }
        Write-Host "[$(Get-Date -Format T)] Speaking: $($text.Trim().Substring(0, [Math]::Min(70, $text.Trim().Length)))..."
        Say $text
      }
    }
  } catch { Write-Host "Jarvis: couldn't speak that one. $_" }
}
