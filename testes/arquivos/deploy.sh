killall java;
rm -rf /opt/apache-tomcat-9.0.30/;
unzip apache-tomcat-9.0.30.zip;
sudo chmod -R 777 /opt/apache-tomcat-9.0.30/;
rm -rf /opt/apache-tomcat-9.0.30/webapps/ROOT*;
cp /opt/ROOT.war /opt/apache-tomcat-9.0.30/webapps/;
sh /opt/apache-tomcat-9.0.30/bin/startup.sh;
