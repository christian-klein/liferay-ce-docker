printf "
============================================
        ___               ___  ___
       / _ )___  ___ ___ |_  ||_  |
      / _  / _ \`(_-</ -_) __// __/
     /____/\_,_/___/\__/____/____/

============================================\n"

# remove existing working directories
rm -rf /opt/liferay/osgi/state/*
rm -rf /opt/tomcat/temp/*
rm -rf /opt/tomcat/work/*

printf "\n-> Environment Variables:\n"
env
printf "\n-> Starting server...\n"
/opt/tomcat/bin/catalina.sh run