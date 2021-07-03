# os-newify: Operating System Newify

A set of steps to update, clean, and reset different types of operating systems to boost security and make the device(s) more efficient.

There are two sections:

* **Windows 10**
* **Linux Distributions**


## Windows 10

**Update** (any that may be avaliable to your device):
* Microsoft Store: `get updates`
* Windows 10: `check for updates`
* Driver Booster 8: `scan (for driver updates)`
* Intel: `driver updates`
* Nvidia GeForce: `check GPU driver`

**Clean / Reset**:

* MalwareBytes: `scan`
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

## Linux Distributions

**General Update:**

`sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y`
* **update** - updates the list of packages but do not install
* **upgrade** - install new versions of packages if new versions are available
* **full-upgrade** - performs the function of upgrade but will remove currently installed packages if this is needed to upgrade the system as a whole (fixing bad dependencies then)
* **autoremove**, **autoclean** and **clean** - clean old packages which are not needed any more

**Python Update:**

List all Old Pip Libraries: `pip-review`

Go Through Each Update: `pip-review -i`

**Bleachbit Cleaners**

It is highly unadvised to run all the cleaners unless it is a clean, fresh install.

Install: `sudo apt-get install bleachbit`

Cleaner List: `bleachbit -l > cleanlist`

Run All Cleaners: `while read line; do echo $line; sudo bleachbit -oc $line; done < list`
