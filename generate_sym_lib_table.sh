#!/bin/sh

FILE=/root/.config/kicad/sym-lib-table

echo "(sym_lib_table" > $FILE
find /usr/share/kicad/library/*.lib -printf "%f\n" | awk 'BEGIN { FS="." } ; {print " (lib (name "$1")(type Legacy)(uri ${KICAD_SYMBOL_DIR}/"$0")(options \"\")(descr \"Script generated, no description\"))"}' >> $FILE
echo ")" >> $FILE
