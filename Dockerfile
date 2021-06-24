# Dockerfile to create an encapsulated verion of the arrows tool for simple graph editing
FROM debian:stable-slim
LABEL MAINTAINER Sean Donnellan <github@donnellan.de>
WORKDIR /opt/app
	# install the required additional packages
	# && clean up after apt to reduce space used.
		RUN apt-get update \
			&& apt-get upgrade -y \
			&& apt-get install -y --no-install-recommends \
				neo4j-client \
				asciidoctor ruby-asciidoctor-pdf ruby-asciidoctor-plantuml ruby-prawn \
				plantuml graphviz xvfb xauth \
                aptitude \
	  		&& rm -rf /var/lib/apt/lists/* \
			&& rm /var/cache/debconf/*-old \
			&& mkdir -p /root/.local/share /.local/share
		RUN gem install rouge neo4j-asciidoctor-extensions

	# copy the includes across to the docker so to be stand alone.
		COPY . .
	# The CMD is optional and is overridden when options are passed