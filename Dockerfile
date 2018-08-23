FROM ubuntu:xenial
MAINTAINER Mikayel Galyan "admin@zzillasoft.com"

COPY backup.sh /bin/backup-cockroach.sh
RUN apt-get update; apt-get install -y wget s3cmd; apt-get clean; chmod +x /bin/backup-cockroach.sh
# use the version you are using
RUN wget -qO- https://binaries.cockroachdb.com/cockroach-v1.1.7.linux-amd64.tgz | tar  xvz; cp -i cockroach-v1.1.7.linux-amd64/cockroach /usr/local/bin

ENTRYPOINT ["bash"]
CMD ["/bin/backup-cockroach.sh"]