base:
  '*':
    - salt.minion
  'os:(RedHat|CentOS)':
    - match: grain_pcre
    - yum.conf
    - yum.epel
    - selinux