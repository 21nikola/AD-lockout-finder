Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Lockout Finder"
$form.Width = 600
$form.Height = 500
$form.StartPosition = "CenterScreen"

# USER INPUT
$label = New-Object System.Windows.Forms.Label
$label.Text = "Username(s):"
$label.Left = 10
$label.Top = 20
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Left = 140
$textBox.Top = 20
$textBox.Width = 400
$form.Controls.Add($textBox)

# HOURS INPUT
$hoursLabel = New-Object System.Windows.Forms.Label
$hoursLabel.Text = "Last hours:"
$hoursLabel.Left = 10
$hoursLabel.Top = 60
$form.Controls.Add($hoursLabel)

$hoursBox = New-Object System.Windows.Forms.TextBox
$hoursBox.Left = 140
$hoursBox.Top = 60
$hoursBox.Width = 60
$hoursBox.Text = "24"
$form.Controls.Add($hoursBox)

# DC SECTION
$dcLabel = New-Object System.Windows.Forms.Label
$dcLabel.Text = "Select DCs:"
$dcLabel.Left = 10
$dcLabel.Top = 100
$form.Controls.Add($dcLabel)

$dc1 = New-Object System.Windows.Forms.CheckBox
$dc1.Text = "DC1"
$dc1.Left = 140
$dc1.Top = 100
$dc1.Checked = $true
$form.Controls.Add($dc1)

$dc2 = New-Object System.Windows.Forms.CheckBox
$dc2.Text = "DC2"
$dc2.Left = 140
$dc2.Top = 130
$form.Controls.Add($dc2)

$dc3 = New-Object System.Windows.Forms.CheckBox
$dc3.Text = "DC3"
$dc3.Left = 140
$dc3.Top = 160
$form.Controls.Add($dc3)

# BUTTON
$button = New-Object System.Windows.Forms.Button
$button.Text = "Search"
$button.Left = 140
$button.Top = 200
$button.Width = 100
$form.Controls.Add($button)

# OUTPUT LIST
$outputBox = New-Object System.Windows.Forms.ListBox
$outputBox.Left = 10
$outputBox.Top = 250
$outputBox.Width = 560
$outputBox.Height = 180
$form.Controls.Add($outputBox)

# STATUS
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Ready"
$statusLabel.Left = 10
$statusLabel.Top = 440
$form.Controls.Add($statusLabel)

# BUTTON CLICK
$button.Add_Click({

    $outputBox.Items.Clear()

    # VALIDACIJA USERA
    if ([string]::IsNullOrWhiteSpace($textBox.Text)) {
        $outputBox.Items.Add("Please enter username(s)")
        return
    }

    # VALIDACIJA HOURS
    if (-not [int]::TryParse($hoursBox.Text, [ref]$null)) {
        $outputBox.Items.Add("Hours must be a number")
        return
    }

    $hours = [int]$hoursBox.Text

    # USERS LIST
    $users = $textBox.Text -split "," | ForEach-Object { $_.Trim().ToLower() }

    # DC SELECTION
    $selectedDCs = @()

    if ($dc1.Checked) { $selectedDCs += "DC1" }
    if ($dc2.Checked) { $selectedDCs += "DC2" }
    if ($dc3.Checked) { $selectedDCs += "DC3" }

    if ($selectedDCs.Count -eq 0) {
        $outputBox.Items.Add("Please select at least one DC")
        return
    }

    $statusLabel.Text = "Searching..."

    try {
        $cred = Get-Credential

        foreach ($dc in $selectedDCs) {

            $events = Get-WinEvent -ComputerName $dc -Credential $cred -FilterHashtable @{
                LogName = 'Security'
                ID = 4740
                StartTime = (Get-Date).AddHours(-$hours)
            } | Sort-Object TimeCreated -Descending

            foreach ($event in $events) {

                $targetUser = $event.Properties[0].Value
                $caller = $event.Properties[1].Value
                $time = $event.TimeCreated

                if ($users -contains $targetUser.ToLower()) {
                    $outputBox.Items.Add("DC: $dc | User: $targetUser | PC: $caller | Time: $time")
                }
            }
        }

        if ($outputBox.Items.Count -eq 0) {
            $outputBox.Items.Add("No lockouts found.")
        }

        $statusLabel.Text = "Done"
    }
    catch {
        $outputBox.Items.Add("Error: " + $_)
        $statusLabel.Text = "Error"
    }
})

$form.ShowDialog()