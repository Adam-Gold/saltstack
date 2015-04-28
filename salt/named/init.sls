install_named:
  pkg:
    - installed
    - pkgs:
      - {{ pillar['pkgs']['bind'] }}
      - {{ pillar['pkgs']['bind-utils'] }}
  service.running:
    - name: {{ pillar['pkgs']['bind9'] }}
    - enable: True
    - restart: True
    - watch:
      - file: {{ pillar['paths']['named'] }}/named.conf

{{ pillar['paths']['named'] }}/named.conf:
  file.managed:
    - user: {{ pillar['pkgs']['named'] }}
    - group: {{ pillar['pkgs']['named'] }}
    - mode: '0440'
    - source: salt://named/templates/named.conf
    - replace: False

{{ pillar['paths']['zones'] }}:
  file.directory:
    - user: {{ pillar['pkgs']['named'] }}
    - group: {{ pillar['pkgs']['named'] }}
    - mode: '0750'
    - makedirs: True
