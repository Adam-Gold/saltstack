exim:
  {% if grains['osrelease'].startswith('5') %}
  {% if grains['cpuarch'] == 'x86_64' %}
  libsrs_alt_rpm: http://dl.atrpms.net/el5-x86_64/atrpms/stable/libsrs_alt-1.0-3_rc1.0.el5.x86_64.rpm
  libsrs_alt_file: libsrs_alt-1.0-3_rc1.0.el5.x86_64.rpm
  libsrs_alt1_rpm: http://dl.atrpms.net/el5-x86_64/atrpms/stable/libsrs_alt1-1.0-3_rc1.0.el5.x86_64.rpm
  libsrs_alt1_file: libsrs_alt1-1.0-3_rc1.0.el5.x86_64.rpm
  exim_rpm: http://dl.atrpms.net/el5-x86_64/atrpms/testing/exim-4.80.1-49.el5.x86_64.rpm
  exim_file: exim-4.80.1-49.el5.x86_64.rpm
  {% elif grains['cpuarch'] == 'i686' %}
  libsrs_alt_rpm: http://dl.atrpms.net/el5-i386/atrpms/stable/libsrs_alt-1.0-3_rc1.0.el5.i386.rpm
  libsrs_alt_file: libsrs_alt-1.0-3_rc1.0.el5.i386.rpm
  libsrs_alt1_rpm: http://dl.atrpms.net/el5-i386/atrpms/stable/libsrs_alt1-1.0-3_rc1.0.el5.i386.rpm
  libsrs_alt1_file: libsrs_alt1-1.0-3_rc1.0.el5.i386.rpm
  exim_rpm: http://dl.atrpms.net/el5-i386/atrpms/testing/exim-4.80.1-49.el5.i386.rpm
  exim_file: exim-4.80.1-49.el5.i386.rpm
  {% endif %}
  {% endif %}
