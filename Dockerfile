# Liferay CE 7.1 Beta M1
# BUILD:
# docker build -t rohirrim70/liferay-CE:7.1-m1 .
#
# Execution path for the Liferay service will /opt/liferay-start.sh
#
FROM rohirrim70/centos-jdk
LABEL maintainer Christian Klein <christian.klein@base22.com>

ARG FILE_LOC=./files/
ARG BUNDLE=liferay-ce-portal-7.1-m1
ARG START_SCRIPT=liferay-start.sh
ARG DB=db
ARG DB_PORT=3306
ARG XMX=2048
ARG XMS=2048

# ENVIRONMENT VARIABLES
ENV XMX=${XMX}
ENV	XMS=${XMS}
ENV LIFERAY_HOME=/opt/liferay
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV START_SCRIPT=${START_SCRIPT}
ENV BUNDLE=${BUNDLE}
ENV DB_PORT=${DB_PORT}

########### INSTALL LIFERAY BUNDLE ################
RUN groupadd liferay;useradd -M -s /bin/nologin -g liferay -d /opt/liferay liferay

ADD --chown=liferay:liferay ${FILE_LOC}${START_SCRIPT} /opt
ADD --chown=liferay:liferay ${FILE_LOC}${BUNDLE} /var/lib/${BUNDLE}
RUN ln -s /var/lib/${BUNDLE} /opt/liferay && \
    ln -s /var/lib/${BUNDLE}/$(ls /var/lib/${BUNDLE}|grep tomcat)  /opt/tomcat

ADD --chown=liferay:liferay ${FILE_LOC}portal-setup-wizard.properties /opt/liferay
ADD --chown=liferay:liferay ${FILE_LOC}portal-ext.properties /opt/liferay

RUN chown -h liferay:liferay /opt/liferay /opt/tomcat && \
    chmod u+x /opt/${START_SCRIPT} && \
    sed -i -e "s/-Xms.*m//g" /opt/tomcat/bin/setenv.sh && \
    sed -i -e "s/-Xmx.*m//g" /opt/tomcat/bin/setenv.sh && \
    sed -i -e "s/\$CATALINA_OPTS/\$CATALINA_OPTS -Xmx${XMX}m -Xms${XMS}m/g" /opt/tomcat/bin/setenv.sh

USER liferay

EXPOSE 8080/tcp
EXPOSE 11311/tcp

#CMD [ "sh", "-c", "/opt/${START_SCRIPT}" ]
CMD /opt/${START_SCRIPT}