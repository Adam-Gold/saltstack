{% if 0 == salt['cmd.retcode']('test -f /etc/selinux/config') %}
/etc/selinux/config:
  file.sed:
    - before: (permissive|enforcing)$
    - after: disabled
    - limit: ^SELINUX=
{% endif %}

"setenforce 0":
  cmd.run:
    - onlyif: test $(getenforce) = "Enforcing"
