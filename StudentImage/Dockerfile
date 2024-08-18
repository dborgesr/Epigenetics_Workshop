# Workshop epigenetica image
FROM --platform=linux/amd64 debian:bookworm-slim 
USER root

ENV APT_PACKAGES=" \
		software-properties-common \
		apt-transport-https \
		ca-certificates \
		locales \
		fonts-liberation \
		apt-utils \
		libreadline-dev \
		zlib1g-dev \
		libgsl0-dev \
		wget \
		bzip2 \
		curl \
		zip \
		build-essential \
		autoconf \
		libhdf5-dev \
		cmake \
		"

#Set up shell for install
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash","-c"]
ENV BASH_EN=~/.bashrc 
ENV SHELL=/bin/bash

#Get apt packages
RUN apt-get update && \
	apt-get install -y --no-install-recommends $APT_PACKAGES && \
 	rm -rf "/var/lib/apt/lists/*" && \
	apt-get clean && \
	rm -rf /var/cache/apt

#Get micromamba
COPY environment.yml /tmp/environment.yml
ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH "$MAMBA_ROOT_PREFIX/bin:$PATH"
RUN wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba --strip-components=1 && \
	chmod 755 ./micromamba && \
	mkdir -p $(dirname $MAMBA_ROOT_PREFIX) && \
	./micromamba shell init -s bash -p $MAMBA_ROOT_PREFIX && \
	echo "micromamba activate base" >> /root/.bashrc && \
	source ~/.bashrc && \
	./micromamba install -y -n base -f /tmp/environment.yml && \
	ln -s /micromamba /usr/bin/conda && \
	ln -s /micromamba /opt/conda/bin/conda && \
	micromamba clean --all --yes && \
	rm ${MAMBA_ROOT_PREFIX}/lib/*.a && \
	rm -rf ${MAMBA_ROOT_PREFIX}/pkgs

# Get kallisto and build from source -_-
RUN git clone https://github.com/pachterlab/kallisto.git && \
	cd ./kallisto/ext/htslib && \
	autoheader && \
	autoheader && \
	cd ../../ && \
	mkdir build && \
	cd build && \
	cmake .. && \
	make && \
	make install 

# Set Epigenetics_Workshop as workdir and copy repo
ENV LOCAL_BASE="/data"
ENV LOCAL_NAME="Epigenetics_Workshop"
ENV LOCAL_REPO="${LOCAL_BASE}/${LOCAL_NAME}"

RUN mkdir -p ${LOCAL_REPO} && \
	cd ${LOCAL_BASE} && \
	git clone https://github.com/dborgesr/Epigenetics_Workshop.git && \
	chmod -R 0777 ${LOCAL_REPO}
WORKDIR ${LOCAL_BASE}

#Configure jupyter
ENV JUPYTER_PREFIX="/root/"
RUN jupyter lab --generate-config && \
	sed -i "/c.ServerApp.open_browser/c c.ServerApp.open_browser = False" "$JUPYTER_PREFIX".jupyter/jupyter_lab_config.py \
        && sed -i "/c.ServerApp.ip/c c.ServerApp.ip = '*'" "$JUPYTER_PREFIX".jupyter/jupyter_lab_config.py \
        && sed -i "/c.ServerApp.root_dir/c c.ServerApp.root_dir = '$WORK_DIR'" "$JUPYTER_PREFIX".jupyter/jupyter_lab_config.py \
        && sed -i "/c.ServerApp.token/c c.ServerApp.token = 'epigenetica'" "$JUPYTER_PREFIX".jupyter/jupyter_lab_config.py \
        && sed -i "/c.ServerApp.iopub_data_rate_limit/c c.ServerApp.iopub_data_rate_limit = 10000000" "$JUPYTER_PREFIX".jupyter/jupyter_lab_config.py

ENV JUPYTER_PORT=8900
EXPOSE $JUPYTER_PORT

ENTRYPOINT jupyter lab --allow-root --port=$JUPYTER_PORT --no-browser --ip=0.0.0.0