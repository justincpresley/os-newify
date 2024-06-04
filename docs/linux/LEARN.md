## Linux Distributions Learn

### Useful Free Software and Methods

* Use LibreSSL instead of OpenSSL

### General Updates

You can create an `renew` alias which maps to the following..

`sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y`

* **update** - updates the list of packages but do not install
* **upgrade** - install new versions of packages if new versions are available
* **full-upgrade** - performs the function of upgrade but will remove currently installed packages if this is needed to upgrade the system as a whole (fixing bad dependencies then)
* **autoremove**, **autoclean** and **clean** - clean old packages which are not needed any more

### Python Library Updates

Install: `pip3 install pip-review`

List all Old Pip Libraries: `pip-review`

Go Through Each Update: `pip-review -i`

### Lynis

Install: `sudo apt-get install lynis`

Usage: `lynis audit system`

### Bleachbit Cleaners

It is highly unadvised to run all the cleaners unless it is a clean, fresh install.

Install: `sudo apt-get install bleachbit`

Cleaner List: `bleachbit -l > cleanlist`

Run All Cleaners: `while read line; do echo $line; sudo bleachbit -oc $line; done < cleanlist`