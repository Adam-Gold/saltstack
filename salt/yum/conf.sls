{% if grains['os_family'] == 'RedHat' %}
/etc/yum.conf:
  file.managed:
    - mode: '0400'
    - user: root
    - group: root
    {% if grains['osrelease'].startswith('5') %}
    - source: salt://yum/files/yum.conf.centos5
    {% elif grains['osrelease'].startswith('6') %}
    - source: salt://yum/files/yum.conf.centos6
    {% endif %}
{% endif %}
