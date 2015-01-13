#!/bin/bash

#Descarga en el directorio actual

temporal=$(mktemp)
num_paginas=20		#Páginas a descargar

for x in $( seq 1 $num_paginas) ; do
	echo "Descargando pagina $x"
	curl -s "https://vrty.org/top/$x?" | egrep '<a href="/image/[^"]+" image_id' -o  | cut -d"/" -f3 | cut -d "\"" -f1 > $temporal
	for imagen in $(cat $temporal) ; do
		echo "	Descargando imagen $imagen"
		url=$(curl -s 'https://vrty.org/image/'$imagen | egrep 'a href="[^"]+" class="external"><img class="img-responsive"' -o | cut -d "\"" -f 2)
		wget -q $url
	done
done


