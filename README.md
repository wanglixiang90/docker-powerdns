# docker-powerdns

# 1 build docker-powerdns
  cd docker-powerdns  
  docker build -t docker-powerdns .  
# 2 build powerdns-admin-master
  cd powerdns-admin-master  
  docker build -t powerdns-admin .  
# 3 run docker-compose 
  docker-compose -f docker-compose_sqlite.yml up -d  
    
  admin url http://ip:9191/   
  default user/passwd  admin/changeme   
# 4 run pdns-recursor
  vim forw-zone, config local auth domain recursor    
  sh start-pdns-recursor.sh   
