FROM httpd:2.4
COPY assets/alfresco-vhost.conf /usr/local/apache2/conf/extra/alfresco-vhost.conf

RUN set -x \
	&& sed -i 's,#LoadModule socache_shmcb_module modules/mod_socache_shmcb.so,LoadModule socache_shmcb_module modules/mod_socache_shmcb.so,g' /usr/local/apache2/conf/httpd.conf \
	&& sed -i 's,#LoadModule xml2enc_module modules/mod_xml2enc.so,LoadModule xml2enc_module modules/mod_xml2enc.so,g' /usr/local/apache2/conf/httpd.conf \
	&& sed -i 's,#LoadModule rewrite_module modules/mod_rewrite.so,LoadModule rewrite_module modules/mod_rewrite.so,g' /usr/local/apache2/conf/httpd.conf \
	&& sed -i 's,#LoadModule proxy_html_module modules/mod_proxy_html.so,LoadModule proxy_html_module modules/mod_proxy_html.so,g' /usr/local/apache2/conf/httpd.conf \
	&& sed -i 's,#LoadModule proxy_module modules/mod_proxy.so,LoadModule proxy_module modules/mod_proxy.so,g' /usr/local/apache2/conf/httpd.conf \
	&& sed -i 's,#LoadModule proxy_connect_module modules/mod_proxy_connect.so,LoadModule proxy_connect_module modules/mod_proxy_connect.so,g' /usr/local/apache2/conf/httpd.conf \
	&& sed -i 's,#LoadModule proxy_ajp_module modules/mod_proxy_ajp.so,LoadModule proxy_ajp_module modules/mod_proxy_ajp.so,g' /usr/local/apache2/conf/httpd.conf \
	&& sed -i 's,#LoadModule proxy_http_module modules/mod_proxy_http.so,LoadModule proxy_http_module modules/mod_proxy_http.so,g' /usr/local/apache2/conf/httpd.conf \
	&& echo "Include conf/extra/alfresco-vhost.conf" >> /usr/local/apache2/conf/httpd.conf

EXPOSE 80