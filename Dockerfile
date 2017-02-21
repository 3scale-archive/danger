FROM centos/ruby-23-centos7

ADD Gemfile* /tmp/src/
USER 0
RUN $STI_SCRIPTS_PATH/assemble \
 && git config --global user.email "danger@localhost" \
 && git config --global user.name "Danger"
USER default

ENV BUNDLE_GEMFILE="/opt/app-root/src/Gemfile"

ENTRYPOINT ["container-entrypoint", "bundle", "exec"]
