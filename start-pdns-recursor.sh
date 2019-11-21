basedir=/opt/pdns-recursor

docker run -d --name pdns-recursor \
-p 53:53/udp -p 53:53/tcp \
-v ${basedir}/recursor.conf:/etc/pdns/recursor.conf \
-v ${basedir}/forw-zone:/etc/pdns/forw-zone \
lmnetworks/pdns-recursor