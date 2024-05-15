FROM tomcat
COPY abctechnologies.war  /usr/local/tomcat
EXPOSE 8080
CMD ["catalina.sh"]