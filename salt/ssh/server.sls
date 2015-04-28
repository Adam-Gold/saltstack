# installs openssh server and blacklist and defines service
openssh-server:
  pkg:
    - installed

{{ pillar['pkgs']['ssh'] }}:
  service.running:
    - enable: true
    - require:
      - pkg: openssh-server
    - watch:
      - pkg: openssh-server
      - file: /etc/ssh/sshd_config

# Sed sshd_config to use only public key
permit_root_login:
  file.sed:
    - name: /etc/ssh/sshd_config
    - before: (#PermitRootLogin.*|PermitRootLogin.*)
    - after: 'PermitRootLogin without-password'

pubkey_authentication:
  file.sed:
    - name: /etc/ssh/sshd_config
    - before: (#PubkeyAuthentication.*|PubkeyAuthentication.*)
    - after: 'PubkeyAuthentication yes'
