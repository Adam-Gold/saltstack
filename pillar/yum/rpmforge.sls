rpmforge:
  {% if grains['osrelease'].startswith('5') %}
  {% if grains['cpuarch'] == 'x86_64' %}
  rpm: http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm
  rpm_file: rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm
  {% elif grains['cpuarch'] == 'i686' %}
  rpm: http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.i386.rpm
  rpm_file: rpmforge-release-0.5.3-1.el5.rf.i386.rpm
  {% endif %}
  {% elif grains['osrelease'].startswith('6') %}
  {% if grains['cpuarch'] == 'x86_64' %}
  rpm: http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
  rpm_file: rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
  {% elif grains['cpuarch'] == 'i686' %}
  rpm: http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.i686.rpm
  rpm_file: rpmforge-release-0.5.3-1.el6.rf.i686.rpm
  {% endif %}
  {% endif %}

  pubkey: http://apt.sw.be/RPM-GPG-KEY.dag.txt
