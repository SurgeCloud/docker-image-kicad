#FROM ubuntu:18.04
FROM debian:stretch

MAINTAINER tomasz@napierala.org

WORKDIR /root
COPY  ./generate_fp_lib_table.sh \
      ./generate_sym_lib_table.sh \
      ./generate_pcbnew_conf.sh \
      /root/

RUN echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    locales \
    ghostscript \
    python-numpy \
    recordmydesktop \
    sudo \
    xdotool \
    xvfb

RUN apt-get -t stretch-backports install -y --no-install-recommends \
    kicad \
    kicad-common \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# cleanup
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && mkdir -p /root/.config/kicad && mkdir -p /root/.local/share/

ENV LANG en_US.utf8

RUN git clone https://github.com/KiCad/kicad-symbols.git /usr/share/kicad/library
RUN git clone https://github.com/KiCad/kicad-footprints.git /usr/share/kicad/footprints

RUN ./generate_fp_lib_table.sh && \
    ./generate_sym_lib_table.sh && \
    ./generate_pcbnew_conf.sh
