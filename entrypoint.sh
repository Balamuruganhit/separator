#!/bin/bash
ConfFile=framework/entity/config/entityengine.xml
cd /ofbiz

source /root/config.env
DB_TYPE=`echo "$DB_TYPE"`
DB_HOST=db-server

if [ $DB_TYPE = mysql ]; then
	sed -i "265i runtime 'mysql:mysql-connector-java:5.1.47'" build.gradle
	sed -i -e 's/ofbiz?autoReconnect=true/'$MYSQL_DATABASE'?autoReconnect=true/' $ConfFile
	sed -i -e 's/jdbc-username="ofbiz"/jdbc-username="'$MYSQL_USER'"/' $ConfFile
  sed -i -e 's/jdbc-password="ofbiz"/jdbc-password="'$MYSQL_PASSWORD'"/' $ConfFile
	sleep 10
	mysql -h db-server -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ofbizolap; CREATE DATABASE IF NOT EXISTS ofbiztenant; grant all privileges on *.* to '$MYSQL_USER'@'%' identified by '$MYSQL_PASSWORD';"
fi
if [ $DB_TYPE = postgres ]; then
	sed -i "265i runtime 'org.postgresql:postgresql:42.2.5.jre7'" build.gradle
  sed -i -e '482,491s/ofbiz/'$POSTGRES_DB'/' $ConfFile
	sed -i -e 's/jdbc-username="'ofbiz'"/jdbc-username="'$POSTGRES_USER'"/' $ConfFile
  sed -i -e 's/jdbc-password="'ofbiz'"/jdbc-password="'$POSTGRES_PASSWORD'"/' $ConfFile
  PGPASSWORD=$POSTGRES_PASSWORD psql -h $DB_HOST -U $POSTGRES_USER ofbizolap
  PGPASSWORD=$POSTGRES_PASSWORD psql -h $DB_HOST -U $POSTGRES_USER ofbiztenant
fi	
        sed -i -e '40,80s/localderby/'local$DB_TYPE'/g' $ConfFile
        sed -i -e '350,572s/127.0.0.1/'$DB_HOST'/g' $ConfFile

#sed -i 's/force.https.host=/force.https.host='34.125.161.165'/g' framework/webapp/config/url.properties
#sed -i 's/force.http.host=/force.http.host='34.125.161.165'/g' framework/webapp/config/url.properties


#DataLoad command
$DB_LOAD 2>&1

#To start OFBiz
$StartOFBiz 2>&1
