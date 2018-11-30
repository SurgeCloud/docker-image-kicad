#!/bin/bash

echo 'bom_plugins=(plugins  (plugin bom2csv (cmd "xsltproc -o \\"%O\\" \\"/usr/lib/kicad/plugins/bom2csv.xsl\\" \\"%I\\"")))' > \
    /root/.config/kicad/eeschema
echo 'bom_plugin_selected=bom2csv' >> /root/.config/kicad/eeschema
