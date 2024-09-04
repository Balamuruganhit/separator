#### InnOps Ofbiz Implementation Dockerized

##### Prerequest
    
    - Create an VM
    - Install the followings
        sudo apt-get install wget -y
        sudo apt-get install git -y
        
        # Install docker in linux debian 10 
        # Reference : https://docs.docker.com/engine/install/debian/, docker-compose https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-debian-10
        sudo apt-get update
        sudo apt-get install \
            ca-certificates \
            curl \
            gnupg \
            lsb-release
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io
        sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        
    - Create an external IP, by allowing http, https
    - Place the IPs in (146.148.63.74)
    - Place the domain neoerp.pangun.tech in both properties file
      dir 
        - ofbiz/framework/security/config/security.properties        
        - ofbiz/framework/webapp/config/url.properties
        - entrypoint.sh

##### Deployment Steps
    
    Clone the project for the first time
    
    abikrishnan1995@ofbiz-v1:~$ git clone -b dev-pangun-may24 https://github.com/sathishmtech01/ofbiz-docker-v1.git
    Cloning into 'ofbiz-docker-v1'...
    Username for 'https://github.com': sathishmtech01
    Password for 'https://sathishmtech01@github.com': 
    ..........................................
    Resolving deltas: 100% (2444/2444), done.
    
    
    Go to the project folder
    abikrishnan1995@ofbiz-v1:~$ cd ofbiz-docker-v1
    
    Run the docker compose file
    abikrishnan1995@ofbiz-v1:~/ofbiz-docker-v1$ sudo ./compose-up.sh mysql

# List docker container running

      sathish_mtech01@pangun-v0:~/ofbiz-docker-v1$ sudo docker ps
      CONTAINER ID   IMAGE       COMMAND                  CREATED         STATUS         PORTS                                                                                  NAMES
      430706f0173a   ofbiz       "/bin/sh -c './entry…"   8 seconds ago   Up 7 seconds   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:8443->8443/tcp, :::8443->8443/tcp   OFBiz-Containers
      bdce634f3405   mysql:5.7   "docker-entrypoint.s…"   9 seconds ago   Up 8 seconds   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp                                   DB-Containers

# Checking the container logs
      sathish_mtech01@pangun-v0:~/ofbiz-docker-v1$ sudo docker logs -f 430706f0173a
      Downloading https://services.gradle.org/distributions/gradle-6.5-bin.zip
      .........10%..........20%..........30%..........40%.........50%..........60%..........70%..........80%.........90%..........100%
      
      Welcome to Gradle 6.5!
      ..............


#### Pangun Docker

      Deploy Apache OFBiz Using Docker on GCP VM

         Required softwares.
         1. Docker-ce installed.
         2. Docker-compose installed.
         3. Git Installed.

      Steps to  Created Docker of OFBiz.

      Step 1. Clone This repo

      Step 2. Go to cloned directory.

      a) Deploy OFBiz with Mysql Database.
         # sudo ./compose-up.sh mysql
 
      b) Deploy OFBiz with PostgreSQL Database.
      # ./compose-up.sh postgres

      Step 5. Access Apache OFBiz at https://hostip:8443/ and https://hostip:8443/webtools/control/main

      Step 6. To stop and remove containers run
# ./compose-down.sh msyql/postgres


#### SSL certificate

      sudo apt install certbot
      sathish_mtech01@pangun-v1:~$ sudo certbot certonly --manual --preferred-challenges=dns -d neoerp.pangun.tech
      Saving debug log to /var/log/letsencrypt/letsencrypt.log
      Requesting a certificate for neoerp.pangun.tech

         - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
         Please deploy a DNS TXT record under the name:

         _acme-challenge.neoerp.pangun.tech.
         
         with the following value:
         
         75OL96LUqiBH-WvKQgI7Dn4PQZI6YI2Imhiz9ZrD2YM

         Before continuing, verify the TXT record has been deployed. Depending on the DNS
         provider, this may take some time, from a few seconds to multiple minutes. You can
         check if it has finished deploying with aid of online tools, such as the Google
         Admin Toolbox: https://toolbox.googleapps.com/apps/dig/#TXT/_acme-challenge.neoerp.pangun.tech.
         Look for one or more bolded line(s) below the line ';ANSWER'. It should show the
         value(s) you've just added.

         - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
         Press Enter to Continue
         
         Successfully received certificate.
         Certificate is saved at: /etc/letsencrypt/live/neoerp.pangun.tech/fullchain.pem
         Key is saved at:         /etc/letsencrypt/live/neoerp.pangun.tech/privkey.pem
         This certificate expires on 2024-07-28.
         These files will be updated when the certificate renews.

      NEXT   STEPS:

      This certificate will not be renewed automatically. Autorenewal of --manual certificates requires the use of an authentication hook script (--manual-auth-hook) but one was not provided. To renew this certificate, repeat this same certbot command before the certificate's expiry date.

      - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      If you like Certbot, please consider supporting our work by:
      * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
      * Donating to EFF:                    https://eff.org/donate-le
     - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

      Certs available https://docs.google.com/document/d/1tJyWnzvAMulq7iOvT08Qa1xBa6O2BdeNgWohz6R-62Q/edit

#### NGINX setup
   
      sudo apt install nginx
      Configure NGINX with SSL:
      Create a Configuration File for Your Subdomain with SSL:
      bash
      Copy code
      sudo nano /etc/nginx/sites-available/neoerp.pangun.tech
      Add the following configuration:
      nginx
      Copy code
      server {
      listen 443 ssl;
      server_name neoerp.pangun.tech;
   
      ssl_certificate /home/ubuntu/fullchain.pem;
      ssl_certificate_key /home/ubuntu/privkey.pem;

         # SSL Configuration (adjust according to your needs)
         ssl_protocols TLSv1.2 TLSv1.3;
         ssl_prefer_server_ciphers on;
         ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
         ssl_session_timeout 1d;
         ssl_session_cache shared:SSL:50m;
         ssl_stapling on;
         ssl_stapling_verify on;
         add_header Strict-Transport-Security max-age=15768000;
      
         location / {
         proxy_pass https://localhost:8443;
         proxy_set_header Host $host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto $scheme;
         }
         }
         Replace subdomain.yourdomain.com with your actual subdomain, and replace /path/to/your/subdomain_cert.pem and /path/to/your/subdomain_key.pem with the paths to your SSL certificate and private key files.
      
      Replace https://your_vm_external_ip:8443 with the HTTPS URL of your application running on the GCP VM instance.

         Activate the Configuration:
         sudo ln -s /etc/nginx/sites-available/neoerp.pangun.tech /etc/nginx/sites-enabled/
     Test Configuration and Restart NGINX:
     Before restarting NGINX, test the configuration:
     sudo nginx -t
     If the test is successful, restart NGINX:
     sudo systemctl restart nginx
     4. Final Steps:
     Verify that your application is accessible via the subdomain served by GoDaddy over HTTPS.
     Test the SSL configuration using SSL Labs or a similar tool.
     Monitor NGINX logs (/var/log/nginx/access.log and /var/log/nginx/error.log) for any issues.
     Following these steps should allow you to create SSL certificates using OpenSSL and configure NGINX to use SSL for secure communication with your application. Adjust the configuration according to your specific requirements.


