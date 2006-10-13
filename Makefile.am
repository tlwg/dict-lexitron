EXTRA_DIST= \
	LICENSE LICENSE-th parse_etlex.pl parse_telex.pl \
	lexitron.info etlex.utf-8 telex.utf-8

dictdata_DATA = etlex.dict.dz telex.dict.dz etlex.index telex.index

etlex.c5: $(srcdir)/etlex.utf-8
	${PERL} $(srcdir)/parse_etlex.pl $(srcdir)/etlex.utf-8 \
		> etlex.c5 2>/dev/null

telex.c5: $(srcdir)/telex.utf-8
	${PERL} $(srcdir)/parse_telex.pl $(srcdir)/telex.utf-8 \
		> telex.c5 2>/dev/null

etlex.dict.dz: etlex.c5 $(srcdir)/lexitron.info
	cat $(srcdir)/lexitron.info etlex.c5 | \
		LC_ALL=th_TH.UTF-8 ${DICTFMT} -c5  \
		-u ftp://ftp.opentle.org/pub/lexitron/source/lexitron-data.zip \
		-s "LEXiTRON version 2, etlex" --without-info \
		--allchars --utf8 etlex
	${DICTZIP} etlex.dict

telex.dict.dz: telex.c5 $(srcdir)/lexitron.info
	cat $(srcdir)/lexitron.info telex.c5 | \
		LC_ALL=th_TH.UTF-8 ${DICTFMT} -c5  \
		-u ftp://ftp.opentle.org/pub/lexitron/source/lexitron-data.zip \
		-s "LEXiTRON version 2, telex" --without-info \
		--allchars --utf8 telex
	${DICTZIP} telex.dict

clean-generic:
	rm -f *.dz *.dict *.c5 *.index
