FROM centos/ruby-23-centos7

ADD Gemfile* /tmp/src/
USER 0
RUN $STI_SCRIPTS_PATH/assemble
USER default

ENTRYPOINT ["container-entrypoint", "bundle", "exec"]
