ARG DEVCONTAINER_IAMGE=${DEVCONTAINER_IAMGE:-devcontainer:latest}

FROM ${DEVCONTAINER_IAMGE}
ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR /tmp

ADD ./build/tools /tmp/build
RUN cd /tmp/build \
  && ./install.sh \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /home/*/.cache \
  && rm -rf /tmp/*


ARG BUILD_OPENCLAW_VERSION=latest
ADD ./build/openclaw /tmp/build
RUN cd /tmp/build \
  && ./setup.sh \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /home/*/.cache \
  && rm -rf /tmp/*


ADD ./entrypoint.sh /.entrypoint.sh
ENTRYPOINT ["/.entrypoint.sh"]
