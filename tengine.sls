install_snort:
    file.recurse:
      - name: /opt/tengine_install
      - source: salt://tengine
      - user: root 
      - file_mode: 644
      - dir_mode: 755
      - mkdir: True
      - clean: True
    pkg.installed:
      - pkgs:
        - gcc
        - gcc-c++
        - autoconf
        - automake
        - zlib
        - zlib-devel
        - openssl
        - openssl-devel
        - pcre
        - pcre-devel
        - jemalloc
        - jemalloc-devel
    cmd.script:
      - source: salt://tengine/intengine.sh
      - user: root
