# EpiTeacher image
FROM --platform=linux/amd64 epistudent:latest
USER root

#Set up shell for install
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash","-c"]
ENV BASH_EN=~/.bashrc 
ENV SHELL=/bin/bash

#Get micromamba
COPY environment.yml /tmp/environment.yml
ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV PATH="$MAMBA_ROOT_PREFIX/bin:$PATH"
RUN source ~/.bashrc && \
	micromamba install -y -n base -f /tmp/environment.yml && \
	micromamba clean --all --yes && \
	rm -rf ${MAMBA_ROOT_PREFIX}/pkgs

#Add users
COPY add_users.sh /tmp/add_users.sh
RUN chmod +x /tmp/add_users.sh && \
	/tmp/add_users.sh

#Configure jupyterhub
ENV JUPYTER_PREFIX="/root/"
RUN cd ${JUPYTER_PREFIX}.jupyter && \
	jupyterhub --generate-config && \
	sed -i "/c.Spawner.notebook_dir/c c.Spawner.notebook_dir = '/data' " "$JUPYTER_PREFIX".jupyter/jupyterhub_config.py && \
	sed -i "/c.JupyterHub.authenticator_class/c c.JupyterHub.authenticator_class = 'jupyterhub.auth.PAMAuthenticator'" "$JUPYTER_PREFIX".jupyter/jupyterhub_config.py 
