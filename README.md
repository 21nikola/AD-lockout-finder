# 🔒 AD Lockout Finder (GUI)

A PowerShell-based GUI tool for detecting Active Directory account lockouts (Event ID 4740).

---

## 🚀 Features

- GUI interface (no command line needed)
- Multi-user search
- Multi-domain controller selection (DC1, DC2, DC3)
- Adjustable time range
- Displays lockout source (computer name)

---

## 🖥️ Usage

1. Open PowerShell
2. Navigate to script folder:
```powershell
cd path\to\script

Run:
.\lockout-finder.ps1

⚠️ Requirements
If execution is blocked, run:
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

🔐 Security

Uses Get-Credential for secure authentication
No credentials are stored
Runs locally without external connections

👨‍💻 Author
Nikola Miščević