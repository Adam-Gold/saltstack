paths:
  {% if grains['os_family'] == 'RedHat' %}
  exim_conf_path: /etc/exim/exim.conf
  exim_branch_path: /etc/exim/exim-branch.conf
  exim_localdomains: /etc/exim/localdomains
  exim_localrelay_path: /etc/exim/exim-localrelay.conf
  exim_homedir: /etc/exim
  named: /var/named/chroot/etc
  zones: /var/named/chroot/etc/zones
  iptables: /etc/sysconfig/iptables
  {% elif grains['os_family'] == 'Debian' %}
  exim_conf_path: /etc/exim4/exim4.conf
  exim_branch_path: /etc/exim4/exim-branch.conf
  exim_localdomains: /etc/exim4/localdomains
  exim_localrelay_path: /etc/exim4/exim-localrelay.conf
  exim_homedir: /etc/exim4
  named: /etc/bind
  zones: /etc/bind/zones
  iptables: /etc/iptables/rules
  {% endif %}