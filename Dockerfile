FROM centos/ruby-23-centos7

ADD Gemfile* /tmp/src/
USER 0
RUN $STI_SCRIPTS_PATH/assemble \
 && git config --global user.email "danger@localhost" \
 && git config --global user.name "Danger" \
 && yum install -y rh-python35 aspell \
 && echo 'source scl_source enable rh-python35' >> /opt/app-root/etc/scl_enable \
 && bash -c 'pip install proselint && npm install -g orta/node-markdown-spellcheck'

ENV BUNDLE_GEMFILE="/opt/app-root/src/Gemfile"

ENTRYPOINT ["container-entrypoint", "bundle", "exec"]
