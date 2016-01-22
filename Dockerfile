# DOCKER-VERSION 1.0.1
FROM ggotti/aem-base
MAINTAINER ggotti

# Install Apache
RUN yum install -y --enablerepo=centosplus libselinux-devel
RUN yum install -y --enablerepo=centosplus httpd
RUN yum install -y tar 

# Download the Dispatcher
RUN wget https://www.adobeaemcloud.com/content/companies/public/adobe/dispatcher/dispatcher/_jcr_content/top/download_12/file.res/dispatcher-apache2.4-linux-x86-64-ssl10-4.1.11.tar.gz
RUN mkdir mkdir -p dispatcher
RUN tar -C dispatcher -zxvf dispatcher-apache2.4-linux-x86-64-ssl10-4.1.11.tar.gz
RUN ls ./dispatcher

# Copy Dispatcher
RUN cp "./dispatcher/dispatcher-apache2.4-4.1.11.so" "/etc/httpd/modules/dispatcher-apache2.4-4.1.11.so"
RUN ln -s /etc/httpd/modules/dispatcher-apache2.4-4.1.11.so /etc/httpd/modules/mod_dispatcher.so

# Add config files
ADD /httpd.conf /etc/httpd/conf/httpd.conf
ADD /dispatcher.any /etc/httpd/conf/dispatcher.any

CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]

EXPOSE 80 443
