## Windows (10/11) Learn

### Free Downloadable Software

* [KeePassXC](https://keepassxc.org/): `self-contained password vault`
* [PDFEncrypt](https://pdfencrypt.net/): `encrypt a pdf file`
* [MalwareBytes](https://www.malwarebytes.com/): `anti-malware/virus`
* [Sysinternals](https://learn.microsoft.com/sysinternals/downloads/): `enhanced system toolset`

**Notes / Advice**
* *KeePass* and *KeePassX* are **not maintained** aka legacy.
* *MalwareBytes* should be used as a 'spot-check' and not permanently installed.
* *DriverEasy* was removed due to recently requiring a subscription.

### Useful Methods

* Load Microsoft Word Documents: `insert -> object -> from-file`
* Encrypt Microsoft Word Documents: `file -> info -> protect doc -> with password`

### Built-in Security Hardening Tools

* Event Viewer: `auditing and logging`
* Task Manager: `process management - viewing`
* Task Scheduler: `process management - scheduling`
* Active Directory: `policy enforcement`
* Group Policy Management Console: `policy enforcement`
* Registry: `system management`
* PowerShell: `system management`
* Windows Terminal / Command Console: `system management`
* Windows Security: `system mangement`
* Windows Defender Firewall: `network management`
* Malicious Software Removal Tool (mrt): `system management`

### Update

*Not all may apply to your device.*

* Microsoft Store: `get updates`
* Windows: `check for updates`
* Intel/AMD/Nvidia: `driver updates`
* Microsoft Office 365 Apps: `account -> update options`
* Any other software updates

### Clean / Reset

*Please look into each method online before trying!*

* MalwareBytes: `scan`
* Run: `"mrt" -> quick scan or full`
* Privacy Settings: `location -> clear`
* File Explorer: `view -> options -> clear file explorer history`
* Run: `"wsreset"`
* CommandLine: `"ipconfig/flushDNS"`
* CommandLine: `"dism.exe /Online /Cleanup-image /Restorehealth"`
* Restore Points: `delete all`
* Delete Temporary files: `delete all`
* Disk Cleanup: `delete all include system`
* Run: `"prefetch" -> delete all`
* Run: `"%temp%" -> delete all`
* Run: `"temp" -> delete all`
* Run: `"SoftwareDistribution" -> delete all`
* Trash Bin: `delete all`
* Optimize Drive: `optimize`
* CommandLine: `"chkdsk"`
* CommandLine: `"sfc /scannow"`