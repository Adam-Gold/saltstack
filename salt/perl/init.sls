perl:
  pkg:
    - installed

{% if grains['os_family'] == 'RedHat' %}
perl-devel:
  pkg:
    - installed
{% endif %}

cpanmminus:
  cmd.run:
    - name: curl -L http://cpanmin.us | perl - --self-upgrade
    - require:
      - pkg: perl
