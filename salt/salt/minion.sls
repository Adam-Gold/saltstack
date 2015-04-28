# Install the salt minion, make sure it started, and starts on boot
salt-minion:
  pkg:
    - installed
  service.running:
    - enable: True
    # Restart salt-minion when /etc/salt/minion changes
    - watch:
      - file: /etc/salt/minion

/etc/salt/minion:
  file.managed:
    - mode: 644
    - source: salt://salt/files/minion
    - template: jinja
    # Don't puth this file down until salt-minion has been installed
    - require:
      - pkg: salt-minion
    - defaults:
        saltserver: '0.0.0.0'