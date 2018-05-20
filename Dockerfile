# Base image
FROM hypriot/rpi-alpine-scratch:v3.4

LABEL maintainer="ryangordon.dev@gmail.com"
# Add the user and groups appropriately
RUN addgroup -S redis && adduser -S -G redis redis

# grab su-exec for step-down from root
RUN apk add --no-cache 'su-exec>=0.2'

# Set environment variables for version control
ENV REDIS_VERSION 3.2.3
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.3.tar.gz
ENV REDIS_DOWNLOAD_SHA1 92d6d93ef2efc91e595c8bf578bf72baff397507

# For redis-sentinel see: http://redis.io/topics/sentinel
RUN set -x \
	\
	&& apk add --no-cache --virtual .build-deps \
		gcc \
		linux-headers \
		make \
		musl-dev \
		tar \
	\
	&& wget -O redis.tar.gz "${REDIS_DOWNLOAD_URL}" \
	&& echo "${REDIS_DOWNLOAD_SHA1} *redis.tar.gz" | sha1sum -c - \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	\
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	\
	&& rm -r /usr/src/redis \
	\
	&& apk del .build-deps

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Expose port
EXPOSE 6379

# Start server
CMD [ "redis-server" ]
