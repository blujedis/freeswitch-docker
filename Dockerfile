FROM debian:buster-slim

# List of Packages
# see: https://files.freeswitch.org/repo/deb/debian-release/dists/buster/main/binary-amd64/Packages

RUN apt-get update && \
apt-get dist-upgrade -y && \
apt-get install -y --no-install-recommends ca-certificates gnupg2 wget lsb-release curl && \
wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add - && \
echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list && \
echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list && \
apt-get update && \
apt-get install -y freeswitch-meta-vanilla && \
curl -k -L  https://github.com/lwahlmeier/sip-ping/releases/download/v1.0.0/sip-ping-linux-amd64 > /usr/bin/sip-ping && \
chmod 755 /usr/bin/sip-ping && \
apt-get remove --purge -y curl gnupg2 wget && \
apt-get clean autoclean && \
apt-get autoremove --yes && \
rm -rf /var/lib/{apt,dpkg,cache,log}/

# Debug
#RUN apt-get install -y --force-yes vim net-tools less gnupg

# Run Configuration
COPY configs/configure.sh /
RUN /configure.sh
RUN rm /configure.sh

# Copy Sip Profile
COPY configs/sip-profile.xml /etc/freeswitch/sip_profiles/

# Copy Dialplan
COPY configs/sip-dialplan.xml /etc/freeswitch/dialplan/

# Copy Conference
COPY configs/conference.conf.xml /etc/freeswitch/autoload_configs/
COPY configs/json_cdr.conf.xml /etc/freeswitch/autoload_configs/

# Copy Entrypoint
COPY entrypoint.sh /
RUN touch /env.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/freeswitch", "-nonat", "-nf", "-nc"]
