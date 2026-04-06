FROM debian:13-slim
ARG DEBIAN_FRONTEND=noninteractive

COPY --from=shinsenter/su-exec:latest \
  --chown=root:root --chmod=0755 \
  /su-exec /usr/local/sbin/su-exec

ARG BUILD_AGENT_UID=233
ARG BUILD_AGENT_USER_NAME=agent
ARG BUILD_AGENT_USER_HOME=/home/${BUILD_AGENT_USER_NAME}

ARG BUILD_UID=1000
ARG BUILD_GID=1000
ARG BUILD_USER_NAME=admin
ARG BUILD_GROUP_NAME=devops
ARG BUILD_USER_HOME=/home/${BUILD_USER_NAME}

ARG BUILD_LANG=zh_CN.UTF-8
ARG BUILD_TZ=Etc/GMT-8

ARG BUILD_APT_MIRROR=mirrors.aliyun.com
ADD ./build/install-base-tools /tmp/build
RUN cd /tmp/build \
  && ./install.sh \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /home/*/.cache \
  && rm -rf /tmp/*


ARG BUILD_PIP_MIRROR=https://mirrors.aliyun.com/pypi/simple
ARG BUILD_PIP_EXTRA_MIRROR=https://mirrors.volces.com/pypi/simple
ARG BUILD_UV_PYTHON_INSTALL_MIRROR=https://mirrors.ustc.edu.cn/github-release/astral-sh/python-build-standalone/
ARG BUILD_NODEJS_MIRROR=https://npmmirror.com/mirrors/node/
ARG BUILD_NPM_MIRROR=https://registry.npmmirror.com
ARG BUILD_GOMIRROR=https://golang.google.cn
ARG BUILD_GOPROXY=https://goproxy.cn,direct
ARG BUILD_RUST_RUSTUP_INIT_SCRIPT_MIRROR=https://rsproxy.cn/rustup-init.sh
ARG BUILD_RUST_RUSTUP_MIRROR=https://rsproxy.cn/rustup
ARG BUILD_RUST_MIRROR=https://rsproxy.cn
ARG BUILD_RUBY_MIRROR=https://cache.ruby-china.com
ARG BUILD_RUBY_GEM_MIRROR=https://gems.ruby-china.com
ARG BUILD_PHP_MIRROR=https://mirrors.ctyun.cn/php
ADD ./build/install-dev-tools /tmp/build
RUN cd /tmp/build \
  && ./install.sh \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /home/*/.cache \
  && rm -rf /tmp/*


ARG BUILD_DOCKER_GID=991
ARG BUILD_K8S_MIRROR=https://mirrors.aliyun.com/kubernetes-new
ADD ./build/install-ops-tools /tmp/build
RUN cd /tmp/build \
  && ./install.sh \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /home/*/.cache \
  && rm -rf /tmp/*


ARG BUILD_OPENSPEC_VERSION=latest
ARG BUILD_OPENCODE_AI_VERSION=latest
ARG BUILD_CLAUDE_CODE_VERSION=latest
ARG BUILD_GEMINI_CLI_VERSION=latest
ARG BUILD_CODEX_VERSION=latest
ADD ./build/install-agent-tools /tmp/build
RUN cd /tmp/build \
  && ./install.sh \
  && apt clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /home/*/.cache \
  && rm -rf /tmp/*


ADD ./entrypoint.sh /.entrypoint.sh
WORKDIR ${BUILD_USER_HOME}
ENTRYPOINT ["/.entrypoint.sh"]
USER ${BUILD_USER_NAME}
