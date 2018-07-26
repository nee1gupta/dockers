FROM tomcat:8.0.53-jre8

RUN cd /tmp && \
   curl -LO "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
   unzip jce_policy-8.zip && \
   cp -v UnlimitedJCEPolicyJDK8/*.jar $JAVA_HOME/lib/security && \
   rm -rf UnlimitedJCEPolicy* jce_policy-8.zip

COPY packages/axis2-1.5.4-war.zip /tmp/
RUN unzip /tmp/axis2-1.5.4-war.zip -d $CATALINA_HOME/webapps && \
    rm -rf /tmp/axis2-1.5.4-war.zip
