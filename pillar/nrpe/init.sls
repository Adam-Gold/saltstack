{% if grains['os_family'] == 'RedHat' %}
nrpe:
  nagios-plugins: http://www.nagios-plugins.org/download/nagios-plugins-2.0.2.tar.gz
  nagios-plugins-sha1: sha1=31713f345798eb114df8af5f9f2966681e4ddb67
  nagios-plugins-folder: nagios-plugins-2.0.2
  nagios-nrpe: http://pkgs.fedoraproject.org/repo/pkgs/nrpe/nrpe-2.15.tar.gz/3921ddc598312983f604541784b35a50/nrpe-2.15.tar.gz
  nagios-nrpe-md5: md5=3921ddc598312983f604541784b35a50
  nagios-nrpe-folder: nrpe-2.15
{% endif %}
  nagios-servers: [ '127.0.0.1' ]
