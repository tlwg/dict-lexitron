all: etlex.dict.dz telex.dict.dz	
etlex.c5: etlex.utf-8
	./parse_etlex.pl etlex.utf-8 > etlex.c5 2>/dev/null
telex.c5: telex.utf-8
	./parse_telex.pl telex.utf-8 > telex.c5 2>/dev/null
etlex.dict.dz: etlex.c5 lexitron.info
	cat lexitron.info etlex.c5 | LC_ALL=th_TH.UTF-8 dictfmt -c5  -u ftp://ftp.opentle.org/pub/lexitron/source/lexitron-data.zip -s "LEXiTRON version 2, etlex" --without-info --allchars --locale th_TH.UTF-8 etlex
	dictzip etlex.dict
telex.dict.dz: telex.c5 lexitron.info
	cat lexitron.info telex.c5 | LC_ALL=th_TH.UTF-8 dictfmt -c5  -u ftp://ftp.opentle.org/pub/lexitron/source/lexitron-data.zip -s "LEXiTRON version 2, telex" --without-info --allchars --locale th_TH.UTF-8 telex
	dictzip telex.dict
install:
	echo copy *.dz and .index to your dictd database directory.
clean:
	rm *.index *.dz *.c5
