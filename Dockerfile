FROM centos:7

RUN \
  yum \
    --assumeyes \
    install centos-release-openshift-origin &&\
  yum \
    --assumeyes \
    install atomic-openshift-utils &&\
  yum clean all;

# Expect user to mount a workdir for container output (installer.cfg, hosts inventory, ansible log)
VOLUME /var/lib/openshift-installer/
WORKDIR /var/lib/openshift-installer/

RUN mkdir -p /var/lib/openshift-installer/

ENTRYPOINT ["/usr/bin/atomic-openshift-installer", "-c", "/var/lib/openshift-installer/installer.cfg", "--ansible-log-path", "/var/lib/openshift-installer/ansible.log"]
