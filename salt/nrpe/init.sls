{% if grains['os_family'] == 'Debian' %}
install_nrpe_{{ grains['os_family'] }}:
  pkg:
    - installed
    - pkgs:
      - nagios-nrpe-server
      - nagios-plugins
      - nagios-plugins-basic
      - nagios-plugins-extra

/etc/nagios/nrpe.cfg:
  file.managed:
    - source: salt://nrpe/templates/debian/nrpe.cfg
    - template: jinja

/etc/nagios/nrpe_local.cfg:
  file.managed:
    - source: salt://nrpe/templates/debian/nrpe_local.cfg
    - template: jinja
{% elif grains['os_family'] == 'RedHat' %}
/usr/local/nagios:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - order: 1

nagios:
  user.present:
    - shell: /bin/bash
    - home: /usr/local/nagios
    - order: 2

extract_nagios_plugins:
  archive:
    - extracted
    - name: /tmp/
    - source: {{ pillar['nrpe']['nagios-plugins'] }}
    - source_hash: {{ pillar['nrpe']['nagios-plugins-sha1'] }}
    - archive_format: tar
    - tar_options: z
    - if_missing: /tmp/{{ pillar['nrpe']['nagios-plugins-folder'] }}
    - unless: which nrpe
    - order: 3


salt://nrpe/scripts/install_nagios_plugins.sh:
  cmd.script:
    - cwd: /tmp/{{ pillar['nrpe']['nagios-plugins-folder'] }}
    - onlyif:
      - test -d /tmp/{{ pillar['nrpe']['nagios-plugins-folder'] }}
    - unless: test -f /usr/local/nagios/libexec/check_ping
    - order: 4

/usr/local/nagios/libexec:
  file.directory:
    - user: nagios
    - group: nagios
    - recurse:
      - user
      - group
    - order: 5

extract_nrpe:
  archive:
    - extracted
    - name: /tmp/
    - source: {{ pillar['nrpe']['nagios-nrpe'] }}
    - source_hash: {{ pillar['nrpe']['nagios-nrpe-md5'] }}
    - archive_format: tar
    - tar_options: z
    - if_missing: /tmp/{{ pillar['nrpe']['nagios-nrpe-folder'] }}
    - unless: which nrpe
    - order: 6

install_nagios_nrpe:
  cmd.script:
    - cwd: /tmp/{{ pillar['nrpe']['nagios-nrpe-folder'] }}
    - source: salt://nrpe/scripts/install_nrpe.sh
    - onlyif: 
      - test -d /tmp/{{ pillar['nrpe']['nagios-nrpe-folder'] }}
    - unless: which nrpe
    - order: 7
    - require:
      - archive: extract_nrpe

{% if 0 != salt['cmd.retcode']('test -f /usr/bin/nrpe') %}
/usr/bin/nrpe:
  file.copy:
    - source: /tmp/{{ pillar['nrpe']['nagios-nrpe-folder'] }}/src/nrpe
{% endif %}

/etc/nrpe.cfg:
  file.managed:
    - user: nagios
    - group: nagios
    - source: salt://nrpe/templates/redhat/nrpe.cfg
    - template: jinja
    - onlyif: which nrpe
    - order: 9

remove_extracted_folders:
  file.absent:
    - names:
      - /tmp/{{ pillar['nrpe']['nagios-plugins-folder'] }}
      - /tmp/{{ pillar['nrpe']['nagios-nrpe-folder'] }}
    - order: last

/etc/init.d/nrpe:
  file.managed:
    - user: root
    - group: root
    - mode: '0775'
    - source: salt://nrpe/files/init/nrpe.init
    - order: 13
{% endif %}

{{ pillar['pkgs']['nrpe'] }}:
  service:
    - running
    - enable: True
    - reload: True
    - order: 15
