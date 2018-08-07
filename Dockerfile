FROM wordpress:php5.6-apache
MAINTAINER Jayesh Jose
RUN apt-get update && apt-get install -y sudo less

# Add WP-CLI 
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY permission.sh /bin/wp
RUN chmod +x /bin/wp-cli.phar /bin/wp

#Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Wordpress Multisite 
RUN sed -r -e 's/\r$//' /usr/src/wordpress/wp-config-sample.php \
	| awk '/^\/\*.*stop editing.*\*\/$/ { print("define( \"SCRIPT_DEBUG\", true );") } { print }' > temp.php \
	&& chown --reference /usr/src/wordpress/wp-config-sample.php temp.php \
	&& mv temp.php /usr/src/wordpress/wp-config-sample.php



