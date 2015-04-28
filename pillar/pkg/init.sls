pkgs:
  {% if grains['os_family'] == 'RedHat' %}
  ssh: sshd
  exim: exim
  iptables: iptables
  vim: vim-enhanced
  nrpe: nrpe
  bind: bind-chroot
  bind-utils: bind-utils
  bind9: named
  named: named
  munin-async: munin-asyncd
  {% elif grains['os_family'] == 'Debian' %}
  ssh: ssh
  exim: exim4
  iptables: iptables-persistent
  vim: vim
  nrpe: nagios-nrpe-server
  bind: bind9
  bind-utils: bind9utils
  bind9: bind9
  named: bind
  munin-async: munin-async
  {% endif %}
