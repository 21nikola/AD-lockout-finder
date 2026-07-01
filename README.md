## 🖥️ Usage

1. Open PowerShell  
2. Navigate to the script folder:

```powershell
cd path	o\script
```

3. Run the script:

```powershell
.\lockout-finder.ps1
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
- Runs locally without external connections  

---

## 👨‍💻 Author

Nikola Miščević
