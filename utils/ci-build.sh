#!/bin/bash -x

http_proxy=${http_proxy:-}
name=bringup-guide

if [ -z "$WORKSPACE" ]
then
	echo '$WORKSPACE required' >&2
	exit 1
fi

echo "Build started, $(date)"

if [ -n "$http_proxy" ]
then
	PROXY='RUN echo "Acquire::http::Proxy \"'"$http_proxy"'\";" > /etc/apt/apt.conf.d/000apt-cacher-ng-proxy'
fi

# build a docker container
docker build -t ${name}-build/ubuntu - << EOF
FROM ubuntu:16.04

$PROXY

ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get update && apt-get install -yy \
	make \
	fonts-inconsolata \
	docbook-xsl \
	docbook-xsl-ns \
	docbook5-xml \
	libsaxon-java \
	libxerces2-java \
	libxslthl-java \
	fop

RUN grep -q $GROUPS /etc/group || groupadd -g $GROUPS $USER
RUN grep -q $UID /etc/passwd || useradd -m -u $UID -g $GROUPS $USER

USER $USER
RUN /bin/bash
EOF

if [ $? -ne 0 ]
then
	echo "Failed to build docker container." >&2
	exit 1
fi

# Create the docker run script
#export PROXY_HOST=${http_proxy/#http*:\/\/}
#export PROXY_HOST=${PROXY_HOST/%:[0-9]*}
#export PROXY_PORT=${http_proxy/#http*:\/\/*:}

mkdir -p "$WORKSPACE"

cat > "$WORKSPACE"/build.sh << EOF
#!/bin/bash -x

cd $WORKSPACE

make
EOF

chmod a+x ${WORKSPACE}/build.sh

# Run the docker container, execute the build script we just built
docker run --cap-add=sys_admin --net=host --rm=true \
	-e WORKSPACE=$WORKSPACE --user="$USER" \
	-v "${WORKSPACE}":"${WORKSPACE}" \
	-t ${name}-build/ubuntu \
	${WORKSPACE}/build.sh
