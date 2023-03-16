Instructions:

In order to mock the google.bintray.com, you have to:
1) Add in /etc/hosts a mapping to redirect google.bintray.com to localhost:
127.0.0.1 google.bintray.com
2) Open the appcargo/docker folder and run: docker-compose up -d
3) Check whether the appcargo-nginx docker is already running: docker ps -a
4) If it is not running, start it: docker start appcargo-nginx
5) Open the Spring Boot project (locationServer) and run it.
Done!
