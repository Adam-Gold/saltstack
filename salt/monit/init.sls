monit:
  pkg:
    - installed
{% if grains['os_family'] == 'RedHat' %}
    - fromrepo: rpmforge
{% endif %}

/etc/monitrc:
  file.managed:
    - user: root
    - group: root
    - mode: '0400'
    - source: salt://monit/files/monit.conf

/etc/monit/conf.d:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True

{% if grains['os_family'] == 'RedHat' %}
delete_monit_files:
  file.absent:
    - names: 
      - /etc/monit.d
      - /etc/monit.conf

/etc/monit.conf:
  file.symlink:
    - target: /etc/monitrc
{% elif grains['os_family'] == 'Debian' %}
/etc/default/monit:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://monit/files/monit.default
{% endif %}
