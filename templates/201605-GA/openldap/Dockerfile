FROM centos:centos7
MAINTAINER keensoft

RUN yum update -y \
	&& yum clean all

RUN yum install -y \
	openldap-servers.x86_64 \
	openldap-clients.x86_64

COPY assets/chrootpw.ldif /tmp/chrootpw.ldif
COPY assets/chdomain.ldif /tmp/chdomain.ldif
COPY assets/basedomain.ldif /tmp/basedomain.ldif
COPY assets/pki/cacert.pem /etc/openldap/certs/cacert.pem
COPY assets/pki/server.crt /etc/openldap/certs/servercrt.pem
COPY assets/pki/server.key /etc/openldap/certs/serverkey.pem
COPY assets/mod_ssl.ldif /tmp/mod_ssl.ldif
ENV LDAP_URLS "ldapi:/// ldap:///"
RUN set -x \
	&& rm -rf /var/lib/ldap/* \
	&& cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG \
	&& chown ldap. /var/lib/ldap/DB_CONFIG \
	&& /usr/sbin/slapd -u ldap -h "${LDAP_URLS}" \
	&& ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/chrootpw.ldif \
	&& rm /tmp/chrootpw.ldif \
	&& ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif \
	&& ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif \
	&& ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif \
	&& ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/chdomain.ldif \
	&& rm /tmp/chdomain.ldif \
	&& ldapadd -x -D cn=Manager,dc=keensoft,dc=es -w secret -f /tmp/basedomain.ldif \
	&& rm /tmp/basedomain.ldif \
	&& ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/mod_ssl.ldif \
	&& rm /tmp/mod_ssl.ldif


EXPOSE 389 636
ENTRYPOINT ["slapd"]
CMD ["-h", "ldap:/// ldapi:/// ldaps:///", "-u", "ldap", "-g", "ldap", "-d0"]
