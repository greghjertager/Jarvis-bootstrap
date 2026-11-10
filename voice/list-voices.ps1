# Lists the text-to-speech voices installed on this PC and saves them to voices.txt next to this script.
$out = Join-Path $PSScriptRoot 'voices.txt'
"Installed voices on $env:COMPUTERNAME, $(Get-Date)" | Out-File $out -Encoding utf8
"" | Out-File $out -Append -Encoding utf8
"== Classic (SAPI) voices ==" | Out-File $out -Append -Encoding utf8
try {
  Add-Type -AssemblyName System.Speech
  $s = New-Object System.Speech.Synthesis.SpeechSynthesizer
  $s.GetInstalledVoices() | ForEach-Object { $v = $_.VoiceInfo; "$($v.Name) | $($v.Culture) | $($v.Gender)" } | Out-File $out -Append -Encoding utf8
} catch { "Could not read SAPI voices: $_" | Out-File $out -Append -Encoding utf8 }
"" | Out-File $out -Append -Encoding utf8
"== Windows (OneCore) voices ==" | Out-File $out -Append -Encoding utf8
try {
  [Windows.Media.SpeechSynthesis.SpeechSynthesizer,Windows.Media.SpeechSynthesis,ContentType=WindowsRuntime] | Out-Null
  [Windows.Media.SpeechSynthesis.SpeechSynthesizer]::AllVoices | ForEach-Object { "$($_.DisplayName) | $($_.Language) | $($_.Gender)" } | Out-File $out -Append -Encoding utf8
} catch { "Could not read Windows voices: $_" | Out-File $out -Append -Encoding utf8 }
Write-Host "Done. Saved the voice list to $out"
