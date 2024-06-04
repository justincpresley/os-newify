# DNS Settings
netsh dns set global doh=yes ddr=no

# Remove pre-existing DNS configuration
netsh dns delete encryption 1.1.1.1
netsh dns delete encryption 1.0.0.1
netsh dns delete encryption 2606:4700:4700::1111
netsh dns delete encryption 2606:4700:4700::1001
netsh dns delete encryption 8.8.8.8
netsh dns delete encryption 8.8.4.4
netsh dns delete encryption 2001:4860:4860::8888
netsh dns delete encryption 2001:4860:4860::8844

# Set our DNS up for encryption
netsh dns set encryption server=9.9.9.9 dohtemplate=https://dns.quad9.net/dns-query autoupgrade=yes udpfallback=no
netsh dns set encryption server=149.112.112.112 dohtemplate=https://dns.quad9.net/dns-query autoupgrade=yes udpfallback=no
netsh dns set encryption server=2620:fe::9 dohtemplate=https://dns.quad9.net/dns-query autoupgrade=yes udpfallback=no
netsh dns set encryption server=2620:fe::fe dohtemplate=https://dns.quad9.net/dns-query autoupgrade=yes udpfallback=no

# Clean past records
Clear-DnsClientCache