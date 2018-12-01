#FROM ubuntu:18.04
FROM debian:stretch

MAINTAINER tomasz@napierala.org

WORKDIR /root
COPY  ./generate_fp_lib_table.sh \
      ./generate_sym_lib_table.sh \
      ./generate_pcbnew_conf.sh \
      ./generate_eeschema_conf.sh \
      /root/

RUN echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ca-cacert \
    curl \
    git \
    locales \
    ghostscript \
    python-lxml \
    python-numpy \
    recordmydesktop \
    sudo \
    xauth \
    xdotool \
    xvfb

RUN apt-get -t stretch-backports install -y --no-install-recommends \
    kicad \
    kicad-common \
    kicad-footprints \
    kicad-symbols \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# cleanup
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && mkdir -p /root/.config/kicad && mkdir -p /root/.local/share/

ENV LANG en_US.utf8

#RUN git clone https://github.com/KiCad/kicad-symbols.git /usr/share/kicad/library/
#RUN git clone https://github.com/KiCad/kicad-footprints.git /usr/share/kicad/footprints/
RUN mkdir -p /usr/lib/kicad/plugins && \
    curl -o /usr/lib/kicad/plugins/bom2csv.xsl \
    https://raw.githubusercontent.com/KiCad/kicad-source-mirror/master/eeschema/plugins/xsl_scripts/bom2csv.xsl
RUN mkdir -p /root/.config/kicad
RUN ./generate_fp_lib_table.sh && \
    ./generate_sym_lib_table.sh && \
    ./generate_pcbnew_conf.sh && \
    ./generate_eeschema_conf.sh
