{% if grains['os_family'] == 'RedHat' %}
epel:
  {% if grains['osrelease'].startswith('5') %}
  rpm: http://download.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
  {% elif grains['osrelease'].startswith('6') %}
  rpm: http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
  {% endif %}
{% endif %}
