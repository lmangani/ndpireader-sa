LIB_DIR=./lib
INCLUDE_NDPI=/usr/src/nDPI
INCLUDE_JSONC=/usr/include/json-c
SRC=./

all:
	gcc -DHAVE_CONFIG_H -I. -I.. -I${INCLUDE_NDPI}/src/include -pthread -g -O2 -I${INCLUDE_JSONC} -MT ndpiReader.o -MD -MP -MF $depbase.Tpo -c -o ndpiReader.o ndpiReader.c &&mv -f $depbase.Tpo $depbase.Po
	/bin/bash /usr/src/nDPI/libtool --tag=CC --mode=link gcc -pthread -g -O2 -I${INCLUDE_JSONC} -static -ljson-c -o ndpiReader ndpiReader.o ${INCLUDE_NDPI}/src/lib/libndpi.la -lpcap && rm ./ndpiReader.o
lib:
	## gcc -L${LIB_DIR} -I${INCLUDE_NDPI}/src/include -lndpi -lpcap ${SRC}/ndpiReader.c -fPIC -shared -o ./libndpireader.so /lib/libndpireader.so.1 /usr/lib/x86_64-linux-gnu/libpcap.so
	gcc -DHAVE_CONFIG_H -I. -I.. -I${INCLUDE_NDPI}/src/include -I${INCLUDE_JSONC} -lndpi -lpcap ndpiReader.c -fPIC -shared -pthread -g -o libndpiReader.so
	

clean:
	rm -Rf ./ndpiReader ndpiReader.o ./*.Po

clean-lib:
	rm -Rf ./libndpireader.so ./*.Po
