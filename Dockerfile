FROM tomcat:11.0

ADD ./webapp/target/*.war /usr/local/webapp/

EXPOSE 8080

CMD ["catalina.sh","run"]