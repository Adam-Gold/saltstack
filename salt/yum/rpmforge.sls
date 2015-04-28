{% if grains['os_family'] == 'RedHat' %}
install_rpmforge:
  cmd.run:
    - names: 
      - rpm --import {{ pillar['rpmforge']['pubkey'] }}
      - rpm -Uvh /tmp/{{ pillar['rpmforge']['rpm_file'] }}
    - onlyif: wget -P /tmp {{ pillar['rpmforge']['rpm'] }}
    - unless: rpm -qa | grep -q rpmforge

del_file_repo:
  file.absent:
    - name: /tmp/{{ pillar['rpmforge']['rpm_file'] }}
    - onlyif: rpm -qa | grep -q rpmforge
{% endif %}
