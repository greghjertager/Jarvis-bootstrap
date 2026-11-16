# Jarvis Control Center v1.1 (public template). Windows only; uses only what ships with Windows.
# Put this folder (control/) inside your Jarvis vault. The window edits the vault's SETTINGS.json,
# which Jarvis reads at the start of every session (Charter section 7).
# A small window for tuning Jarvis. It edits SETTINGS.json in the vault, which Jarvis reads at the
# start of every session (Charter section 7). It also shows read-only status from the vault.
# Writes only: SETTINGS.json, one line in today's session log when a setting changes, and a copy
# of SETTINGS.json in your backup folder if SETTINGS.json names one ("backup_folder"). Uses only what ships with Windows.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$vault        = Split-Path -Parent $PSScriptRoot
$settingsPath = Join-Path $vault 'SETTINGS.json'
$utf8NoBom    = New-Object System.Text.UTF8Encoding($false)

function Read-Settings { Get-Content -Raw -Path $settingsPath -Encoding UTF8 | ConvertFrom-Json }
function Get-BackupDir { try { $b = (Read-Settings).backup_folder; if ($b) { return [Environment]::ExpandEnvironmentVariables($b) } } catch { } ; return $null }

function Get-Status {
  $s = [ordered]@{}
  try {
    $cp = Join-Path $vault 'JARVIS_CHARTER.md'; if (-not (Test-Path $cp)) { $cp = Join-Path $vault 'JARVIS_CHARTER_TEMPLATE.md' }
    $line = (Get-Content $cp -TotalCount 2 -Encoding UTF8)[1]
    if ($line -match 'Version ([\d\.]+)') { $s.Charter = "v$($Matches[1])" } else { $s.Charter = 'unknown' }
  } catch { $s.Charter = 'not found' }
  try {
    $f = Get-ChildItem (Join-Path $vault 'sessions') -Filter '*.md' | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    $s.LastSave = $f.LastWriteTime.ToString('ddd MMM d, h:mm tt')
  } catch { $s.LastSave = 'not found' }
  try {
    $backupDir = Get-BackupDir; if (-not $backupDir) { throw 'none' }
    $raw = (Get-Content (Join-Path $backupDir 'LAST_BACKUP.txt') -TotalCount 1).Trim() -replace ' UTC',''
    $utc = [DateTime]::SpecifyKind([DateTime]::ParseExact($raw, 'yyyy-MM-dd HH:mm', $null), 'Utc')
    $s.LastBackup = $utc.ToLocalTime().ToString('ddd MMM d, h:mm tt')
  } catch { $s.LastBackup = 'no backup folder set' }
  try {
    $w = Get-ChildItem (Join-Path $vault 'watch') -Filter '20*.md' | Sort-Object Name -Descending | Select-Object -First 1
    $wDate = [DateTime]::ParseExact($w.BaseName, 'yyyy-MM-dd', $null)
    $s.LastWatch = $wDate.ToString('ddd MMM d')
    $s.Watch = $w.Name
  } catch { $s.LastWatch = 'none yet' }
  try {
    $j = Get-Content -Raw (Join-Path $vault 'JUDGMENT_LOG.md') -Encoding UTF8
    $total = ([regex]::Matches($j, '(?m)^### J-\d+')).Count
    $scored = ([regex]::Matches($j, '(?m)Verdict:')).Count
    $s.Calls = "$($total - $scored) open of $total"
  } catch { $s.Calls = 'not found' }
  return $s
}

try {
  $cfg = Read-Settings
} catch {
  [System.Windows.Forms.MessageBox]::Show("Couldn't read SETTINGS.json in the vault.`n`n$_", 'Jarvis Control Center') | Out-Null
  exit 1
}

$font  = New-Object System.Drawing.Font('Segoe UI', 10)
$bold  = New-Object System.Drawing.Font('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
$title = New-Object System.Drawing.Font('Segoe UI', 14, [System.Drawing.FontStyle]::Bold)
$contentWidth = 560

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Jarvis Control Center'
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'Sizable'
$form.MaximizeBox = $true
$form.Font = $font

# Everything sits in one vertical flow that sizes itself to its contents and scrolls if needed.
$flow = New-Object System.Windows.Forms.FlowLayoutPanel
$flow.FlowDirection = 'TopDown'
$flow.WrapContents = $false
$flow.AutoScroll = $true
$flow.Dock = 'Fill'
$flow.Padding = New-Object System.Windows.Forms.Padding(12)
$form.Controls.Add($flow)

function New-Text($text, $f, $wrap) {
  $l = New-Object System.Windows.Forms.Label
  $l.Text = $text; $l.AutoSize = $true
  if ($wrap) { $l.MaximumSize = New-Object System.Drawing.Size($wrap, 0) }
  if ($f) { $l.Font = $f }
  $l.Margin = New-Object System.Windows.Forms.Padding(3, 4, 3, 4)
  return $l
}
function New-Section($name) {
  $g = New-Object System.Windows.Forms.GroupBox
  $g.Text = $name; $g.AutoSize = $true; $g.AutoSizeMode = 'GrowAndShrink'
  $g.MinimumSize = New-Object System.Drawing.Size($contentWidth, 0)
  $g.Padding = New-Object System.Windows.Forms.Padding(10, 8, 10, 8)
  $g.Margin = New-Object System.Windows.Forms.Padding(0, 6, 0, 6)
  $t = New-Object System.Windows.Forms.TableLayoutPanel
  $t.AutoSize = $true; $t.AutoSizeMode = 'GrowAndShrink'
  $t.Location = New-Object System.Drawing.Point(10, 24)
  $g.Controls.Add($t)
  $flow.Controls.Add($g)
  return $t
}

$flow.Controls.Add((New-Text 'Jarvis Control Center' $title $contentWidth))
$flow.Controls.Add((New-Text 'Changes take effect at the next session, or when you say "Jarvis, reload settings."' $null $contentWidth))

# --- Personality ---
$tp = New-Section 'Personality'
$tp.ColumnCount = 3
$tp.RowCount = 6
[void]$tp.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::AutoSize)))
[void]$tp.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Absolute, 320)))
[void]$tp.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::AutoSize)))

$witText = @{ 1='None. Pure business.'; 2='Rare. An occasional understated remark.'; 3='Light. A dry aside every few replies.'; 4='Regular. Most casual replies carry one deadpan line.'; 5='Full. A deadpan line in most replies, never a punchline.' }
$script:row = 0
function New-Dial($name, $min, $max, $value, $desc) {
  $tp.Controls.Add((New-Text $name $bold $null), 0, $script:row)
  $t = New-Object System.Windows.Forms.TrackBar
  $t.Minimum = $min; $t.Maximum = $max; $t.Value = [Math]::Min($max, [Math]::Max($min, [int]$value))
  $t.TickFrequency = 1; $t.LargeChange = 1; $t.SmallChange = 1
  $t.Dock = 'Fill'
  $tp.Controls.Add($t, 1, $script:row)
  $v = New-Text "$($t.Value)" $bold $null
  $tp.Controls.Add($v, 2, $script:row)
  $script:row++
  $d = New-Text $desc $null 340
  $tp.Controls.Add($d, 1, $script:row)
  $tp.SetColumnSpan($d, 2)
  $script:row++
  return @($t, $v, $d)
}
$witPair = New-Dial 'Dry wit'   1 5  $cfg.dry_wit   $witText[[int]$cfg.dry_wit]
$witDesc = $witPair[2]
$verPair = New-Dial 'Verbosity' 1 10 $cfg.verbosity '1 terse ... 10 expansive. Jarvis expands anyway for teaching, risk, or complex work.'
$forPair = New-Dial 'Formality' 1 10 $cfg.formality '1 casual ... 10 ceremonial. The Butler standard is 6.'

$witPair[0].Add_ValueChanged({ $witPair[1].Text = "$($witPair[0].Value)"; $witDesc.Text = $witText[$witPair[0].Value] })
$verPair[0].Add_ValueChanged({ $verPair[1].Text = "$($verPair[0].Value)" })
$forPair[0].Add_ValueChanged({ $forPair[1].Text = "$($forPair[0].Value)" })

# --- Address and behaviour ---
$ta = New-Section 'Address and behaviour'
$ta.ColumnCount = 1
$ta.RowCount = 4
$line = New-Object System.Windows.Forms.FlowLayoutPanel
$line.AutoSize = $true; $line.AutoSizeMode = 'GrowAndShrink'; $line.WrapContents = $true
$line.MaximumSize = New-Object System.Drawing.Size(($contentWidth - 30), 0)
$line.Controls.Add((New-Text 'Call me' $bold $null))
$rSir = New-Object System.Windows.Forms.RadioButton; $rSir.Text = 'Sir'; $rSir.AutoSize = $true
$rMaam = New-Object System.Windows.Forms.RadioButton; $rMaam.Text = "Ma'am"; $rMaam.AutoSize = $true
if ($cfg.address -eq "ma'am") { $rMaam.Checked = $true } elseif ($cfg.address -eq 'sir') { $rSir.Checked = $true }
$line.Controls.Add($rSir); $line.Controls.Add($rMaam)
$line.Controls.Add((New-Text '   Sometimes' $bold $null))
$tAlt = New-Object System.Windows.Forms.TextBox; $tAlt.Text = "$($cfg.alternate_address)"; $tAlt.Width = 160
$line.Controls.Add($tAlt)
$ta.Controls.Add($line, 0, 0)

function New-Check($text, $checked, $r) {
  $c = New-Object System.Windows.Forms.CheckBox
  $c.Text = $text; $c.Checked = [bool]$checked; $c.AutoSize = $true
  $ta.Controls.Add($c, 0, $r); return $c
}
$cVoice = New-Check 'Spoken voice (a spoken version of each reply)' $cfg.spoken_voice 1
$cBrief = New-Check 'Briefing at the first check-in each day' $cfg.briefing 2
$cSave  = New-Check 'Ask "save to the vault?" before wrapping up' $cfg.save_reminder 3

# --- Status ---
$ts = New-Section 'Status (from the vault, read-only)'
$ts.ColumnCount = 1
$ts.RowCount = 1
$statusLabel = New-Text '' $null ($contentWidth - 30)
$ts.Controls.Add($statusLabel, 0, 0)
function Update-Status {
  $st = Get-Status
  $statusLabel.Text = "Charter: $($st.Charter)`r`nLast vault save: $($st.LastSave)`r`nLast backup: $($st.LastBackup)`r`nLast morning watch: $($st.LastWatch)`r`nJudgment calls: $($st.Calls)"
}
Update-Status

# --- Security ---
$tx = New-Section 'Security'
$tx.ColumnCount = 1
$tx.RowCount = 1
$secLabel = New-Text 'Vault encryption: OFF. With a hardware key (YubiKey or similar), the unlock timer will show here.' $null ($contentWidth - 30)
$secLabel.ForeColor = [System.Drawing.Color]::DarkRed
$tx.Controls.Add($secLabel, 0, 0)

# --- Buttons ---
$bar = New-Object System.Windows.Forms.FlowLayoutPanel
$bar.AutoSize = $true; $bar.AutoSizeMode = 'GrowAndShrink'; $bar.WrapContents = $true
$bar.MaximumSize = New-Object System.Drawing.Size($contentWidth, 0)
$bar.Margin = New-Object System.Windows.Forms.Padding(0, 8, 0, 0)
function New-Button($text) {
  $b = New-Object System.Windows.Forms.Button
  $b.Text = $text; $b.AutoSize = $true; $b.Padding = New-Object System.Windows.Forms.Padding(8, 2, 8, 2)
  $bar.Controls.Add($b); return $b
}
$bDefaults = New-Button 'My defaults'
$bSave     = New-Button 'Save'
$bClose    = New-Button 'Close'
$flow.Controls.Add($bar)
$msg = New-Text '' $bold $contentWidth
$flow.Controls.Add($msg)
$form.AcceptButton = $bSave

# Size the window to fit everything, within the screen.
$pref = $flow.GetPreferredSize([System.Drawing.Size]::Empty)
if ($pref.Height -lt 400 -or $pref.Width -lt 400) { $pref = New-Object System.Drawing.Size(600, 800) }
$area = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
$w = [Math]::Min($pref.Width + 40, $area.Width - 40)
$h = [Math]::Min($pref.Height + 30, $area.Height - 40)
$form.ClientSize = New-Object System.Drawing.Size($w, $h)
$form.MinimumSize = New-Object System.Drawing.Size(420, 300)

$bDefaults.Add_Click({
  $d = $cfg.defaults
  $witPair[0].Value = [int]$d.dry_wit; $verPair[0].Value = [int]$d.verbosity; $forPair[0].Value = [int]$d.formality
  if ($d.address -eq "ma'am") { $rMaam.Checked = $true } elseif ($d.address -eq 'sir') { $rSir.Checked = $true } else { $rSir.Checked = $false; $rMaam.Checked = $false }
  $tAlt.Text = "$($d.alternate_address)"
  $cVoice.Checked = [bool]$d.spoken_voice; $cBrief.Checked = [bool]$d.briefing; $cSave.Checked = [bool]$d.save_reminder
  $msg.Text = 'Defaults loaded. Press Save to keep them.'
})

$bSave.Add_Click({
  try {
    $old = Read-Settings
    $new = [ordered]@{
      about             = $old.about
      updated           = (Get-Date).ToString('yyyy-MM-ddTHH:mm:sszzz')
      updated_by        = 'Control Center'
      address           = $(if ($rMaam.Checked) { "ma'am" } elseif ($rSir.Checked) { 'sir' } else { '' })
      alternate_address = $tAlt.Text.Trim()
      dry_wit           = $witPair[0].Value
      verbosity         = $verPair[0].Value
      formality         = $forPair[0].Value
      spoken_voice      = $cVoice.Checked
      briefing          = $cBrief.Checked
      save_reminder     = $cSave.Checked
      backup_folder     = $old.backup_folder
      defaults          = $old.defaults
    }
    $changes = @()
    foreach ($k in @('address','alternate_address','dry_wit','verbosity','formality','spoken_voice','briefing','save_reminder')) {
      if ("$($old.$k)" -ne "$($new[$k])") { $changes += "$k $($old.$k) -> $($new[$k])" }
    }
    if ($changes.Count -eq 0) { $msg.Text = 'No changes to save.'; return }
    [System.IO.File]::WriteAllText($settingsPath, ($new | ConvertTo-Json -Depth 4), $utf8NoBom)
    $today = Get-Date
    New-Item -ItemType Directory -Force -Path (Join-Path $vault 'sessions') | Out-Null
    $log = Join-Path $vault ("sessions\" + $today.ToString('yyyy-MM-dd') + '.md')
    if (-not (Test-Path $log)) { [System.IO.File]::WriteAllText($log, "# $($today.ToString('yyyy-MM-dd (ddd)'))`n", $utf8NoBom) }
    [System.IO.File]::AppendAllText($log, "- $($today.ToString('HH:mm')) Settings changed in the Control Center: $($changes -join '; '). (operator, Control Center)`n", $utf8NoBom)
    $backupDir = Get-BackupDir
    if ($backupDir -and (Test-Path $backupDir)) { Copy-Item $settingsPath (Join-Path $backupDir 'SETTINGS.json') -Force }
    $script:cfg = Read-Settings
    $msg.Text = "Saved: $($changes.Count) change(s)."
    Update-Status
  } catch {
    [System.Windows.Forms.MessageBox]::Show("Save failed: $_", 'Jarvis Control Center') | Out-Null
  }
})
$bClose.Add_Click({ $form.Close() })

[void]$form.ShowDialog()
