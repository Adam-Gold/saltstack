disable_mail_services:
  service:
    - dead
    - enable: False
    - names:
      - postfix
      - sendmail
{% if grains['os_family'] == 'RedHat' %}
  install_pkgs:
    pkg:
      - installed
      - pkgs:
        - glibc
        - pam
  {% if grains['osrelease'].startswith('5') %}
  postgresql84-libs:
    pkg:
      - installed

  install_libsrs_alt:
    cmd.run:
      - names:  
        - rpm -Uvh {{ pillar['exim']['libsrs_alt_rpm'] }}
        - rpm -Uvh {{ pillar['exim']['libsrs_alt1_rpm'] }}
      - unless: rpm -qa | grep -q libsrs_alt1

  install_exim:
    cmd.run:
      - name: rpm -Uvh {{ pillar['exim']['exim_rpm'] }}
      - unless: rpm -qa | grep -q exim

  {% elif grains['osrelease'].startswith('6') %}
  exim:
    pkg:
      - installed
  {% endif %}
{% elif grains['os'] == 'Ubuntu' %}
  main_sources_repo:
    pkgrepo.managed:
      - name: deb-src http://archive.ubuntu.com/ubuntu {{ grains['oscodename'] }} main
      - order: 1
{% elif grains['os'] == 'Debian' %}
  main_sources_repo:
    pkgrepo.managed:
      - name: deb-src http://ftp.nl.debian.org/debian {{ grains['oscodename'] }} main
      - order: 1
{% endif %}

{% if grains['os_family'] == 'Debian' %}
  install_deb_build_tools:
    pkg.installed:
      - pkgs:
        - build-essential
        - fakeroot
        - dpkg-dev
        - devscripts

  download_source_code:
    cmd.run:
      - cwd: /tmp
      - names:
        - apt-get -y source exim4
        - apt-get -y build-dep exim4
      - order: 1
      - unless: dpkg -l | grep exim

  {% set exim4_folder = salt['cmd.run']("apt-cache policy exim4 | perl -ne 'print \"exim4-\" . $1 and last if /(\d*\.\d+).*/'") %}
  change_to_openssl:
    file.sed:
      - name: /tmp/{{ exim4_folder }}/debian/rules
      - before: '# OPENSSL:=1'
      - after: 'OPENSSL:=1'
      - unless: dpkg -l | grep exim

  build_exim_with_openssl:
    cmd.run:
      - cwd: /tmp/{{ exim4_folder }}
      - name: dpkg-buildpackage -rfakeroot -uc -b
      - unless: dpkg -l | grep exim


  install_exim_packages:
    cmd.script:
      - cwd: /tmp/
      - source: salt://exim/scripts/install_exim4.pl
      - unless: dpkg -l | grep exim
{% endif %}

deploy_exim_configuration:
  file.managed:
    - name: {{ pillar['paths']['exim_conf_path'] }}
    - user: root
    - group: root
    - mode: '0400'
    - source: salt://exim/files/exim.conf

exim_service:
  service.running:
    - name: {{ pillar['pkgs']['exim'] }}
    - restart: True
    - enable: True
