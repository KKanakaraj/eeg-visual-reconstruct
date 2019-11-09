FROM nvcr.io/nvidia/caffe:19.10-py2

ENV LANG C.UTF-8

ARG DEBIAN_FRONTEND=noninteractive

RUN pip install keras uproot jupyter  jupyterlab matplotlib sklearn tables

RUN apt-get update && \
    apt-get install -y git debconf-utils && \
    apt-get install -y vim less graphviz python3-tk wget

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}
ENV SHELL bash
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}
