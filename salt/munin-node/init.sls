{% if grains['os_family'] == 'RedHat' %}
munin_install:
  pkg.installed:
    - disablerepo: rpmforge
    - pkgs:
      - munin-node
      - munin-async
    - order: 1

munin:
  user.present:
    - shell: /bin/bash
{% elif grains['os'] == 'Debian' %}
python-apt:
  pkg:
    - installed
    - order: 2

debian_backports:
  pkgrepo.managed:
    - humanname: Debian Backports
    - name: deb http://backports.debian.org/debian-backports {{ grains['oscodename'] }}-backports main contrib non-free
    - dist: {{ grains['oscodename'] }}-backports
    - file: /etc/apt/sources.list.d/backports.list
    - order: 3

munin_debian_install:
  pkg.installed:
    - fromrepo: {{ grains['oscodename'] }}-backports
    - refresh: True
    - pkgs:
      - munin-node
      - munin-async
    - order: 4

/etc/init.d/munin-async:
  file.sed:
    - before: munin-async
    - after:  munin
    - limit:  ^DAEMON_USER=
    - order: 5
{% elif grains['os'] == 'Ubuntu' %}
add_tuxpoldo_ppa:
  pkgrepo.managed:
    - ppa: tuxpoldo/munin
    - order: 6

install_munin_ubuntu:
  pkg.installed:
    - pkgs:
      - munin-node
      - munin-async
    - refresh: True
    - order: 7

install_ubic:
  cmd.run:
    - env:
      - PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    - name: cpanm Ubic
    - onlyif: which cpanm
    - order: 8

setup_ubic:
  cmd.run:
    - env:
      - PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    - name: ubic-admin setup --batch-mode
    - onlyif: which ubic-admin
    - order: 9

/etc/ubic/service/munin-async:
  file.managed:
    - source: salt://munin-node/files/ubuntu/munin-async.ubic
    - user: root
    - group: root
    - mode: 0644
    - order: 10

/etc/init.d/munin-async:
  file.managed:
    - source: salt://munin-node/files/ubuntu/munin-async.init
    - user: root
    - group: root
    - mode: 0777
    - order: 11
{% endif %}

{% if grains['os_family'] == 'Debian' %}
update_munin_user:
  user.present:
    - name: munin
    - shell: /bin/bash
    - home: /var/lib/munin-async
    - order: 12

/var/lib/munin-async:
  file.directory:
    - user: munin
    - group: munin
    - recurse:
      - user
      - group
    - order: 13

/var/log/munin-node:
  file.symlink:
    - user: root
    - group: root
    - target: /var/log/munin
    - order: 14


/var/lib/munin:
  file.symlink:
    - user: munin
    - group: munin
    - target: /var/lib/munin-async
    - order: 15
{% endif %}

/etc/munin/munin-node.conf:
  file.managed:
    - source: salt://munin-node/templates/munin-node.conf
    - user: root
    - group: root
    - mode: 400
    - template: jinja
    - defaults:
        host_name: {{ grains.id }}
    - order: 16

munin-node:
  service:
    - running
    - restart: True
    - enable: True
    - watch:
      - file: /etc/munin/munin-node.conf
    - order: 17

{{ pillar['pkgs']['munin-async'] }}:
  service:
    - running
    - enable: True
    - restart: True
    - watch:
      - file: /etc/munin/munin-node.conf
    - order: 18