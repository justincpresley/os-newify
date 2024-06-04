## Windows (10/11) Scripts

> **Warning**
> Windows 11 is forcing more AI bloatware with each release. As such, the provided automation/configuration will not cover everything for future updates.

**Please look at the provided files before apply them.** Responsible falls on you for any broken/unusable OS.

My goal with the provided automation is for the operating system to be minimal but usable. It is not meaning to be extensive.

### O&O ShutUp10++ (oosu)

[O&O ShutUp10++](https://www.oo-software.com/en/shutup10) is a registry-based tool to set quick settings related to privacy and functionality. It is a single EXE application that can be removed after applying the desired settings.

You may use the provided configuration file [**oosu.cfg**](/oosu.cfg) by going `File` **->** `Import`.

### PowerShell Custom Scripts

There are many custom PowerShell scripts provided by this repository. It is highly suggested to **run all scripts as Administrator**.

Some commands will result in errors as they do not apply to you.

Many aspects of these scripts were taken from other repositories.
* [Sycnex](https://github.com/Sycnex/Windows10Debloater) - [license](/copy/license-sycnex.md)
* [W4RH4WK](https://github.com/W4RH4WK/Debloat-Windows-10/tree/master) - [license](/copy/license-w4rh4wk.md)
* [simeononsecurity](https://github.com/simeononsecurity/Windows-Optimize-Harden-Debloat/tree/master) - [license](/copy/license-simeononsecurity.md)

**Notes / Advice**
* `dns-data.ps1` assumes you will use Quad9. You must still manually change your default DNS provider to [Quad9 Info](https://www.quad9.net/service/service-addresses-and-features) by `Settings -> Network & internet -> Wi-Fi -> Wi-Fi/Hardware Properties`.
* Look into `simeononsecurity's repo` for a more intense custom script.



