#!/bin/bash
rm data* 2>/dev/null
xxd -r archivo.txt > data1.bin

nombre_archivo_adentro=$(7z l data1.bin | grep "Name" -A2 | tail -n1| awk 'NF{print $NF}')
7z x data1.bin >/dev/null 2>&1
while true; do
	7z l $nombre_archivo_adentro  >/dev/null 2>&1

	if [ "$(echo $?)" == "0" ] ; then
		nombre_archivo_adentro_nuevo=$(7z l $nombre_archivo_adentro | grep "Name" -A2 | tail -n1| awk 'NF{print $NF}')
		7z x $nombre_archivo_adentro > /dev/null 2>&1 && nombre_archivo_adentro=$nombre_archivo_adentro_nuevo
	else
		cat $nombre_archivo_adentro
		rm data* 2>/dev/null
		exit 1
	fi

done


