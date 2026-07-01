# 🔒 AD Lockout Finder (GUI)

A PowerShell-based GUI tool designed to help system administrators quickly detect and troubleshoot Active Directory account lockouts.

---

## 🚀 Features

- ✅ Graphical interface (no command line needed)
- ✅ Multi-user search support
- ✅ Multi-domain controller selection (DC1, DC2, DC3)
- ✅ Adjustable time range
- ✅ Displays lockout source (computer name)
- ✅ Fast and simple troubleshooting

---

## 🧠 Description

Active Directory account lockouts are a common issue in enterprise environments, often caused by stored credentials, scheduled tasks, or services using outdated passwords.

This tool automates the process of searching Security Event Logs (Event ID 4740) across selected Domain Controllers and identifies:

- 🔹 Which user was locked out
- 🔹 When the lockout occurred
- 🔹 Which computer caused the lockout

By using a simple GUI interface, administrators can quickly identify the root cause without manually parsing logs or running complex commands.

---

## 🖥️ Usage

1. Open PowerShell
2. Navigate to the script folder:

```powershell
cd path\to\script
```

3. Run the script:

```powershell
.\lockout-gui.ps1
```

---

## ⚠️ Requirements

If script execution is blocked, run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 🔐 Security

- Uses `Get-Credential` for secure authentication
- No credentials are stored
- Runs locally without external API calls
- Sensitive data stays on the user's machine

---

## 💼 Use Case

This tool is ideal for:

- System Administrators
- IT Support / Helpdesk
- Active Directory troubleshooting
- Incident response

---

## 🛠️ Tech Stack

- PowerShell
- Windows Forms (WinForms)

---

## 👨‍💻 Author

**Nikola Miščević**
