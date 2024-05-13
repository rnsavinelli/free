#
# free Makefile
# Memory usage utility for Darwin & MacOS X
# by:  David L. Cantrell Jr. <david.l.cantrell@gmail.com>
# See free.c for license and copyright information.
#

VER         = 0.5.2

CWD         = $(shell pwd)
PREFIX      ?= /usr/local

CC          = clang
CFLAGS      = -O2 -Wall -std=c99 -D_FREE_VERSION=\"$(VER)\"
CDEBUGFLAGS = -g

SRCS        = free.c
OBJS        = free.o

free: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o free

install: free
	mkdir -p $(PREFIX)/bin
	mkdir -p $(PREFIX)/share/man/man1
	install -p -s -m 0755 free $(PREFIX)/bin
	install -p -m 0644 free.1 $(PREFIX)/share/man/man1

uninstall:
	rm -rf $(PREFIX)/bin/free
	rm -rf $(PREFIX)/share/man/man1/free.1

clean:
	rm -rf $(OBJS) free free-$(VER).tar.gz

tag:
	git tag -s -m "v$(VER)" v$(VER)

release: tag
	rm -rf free-$(VER)
	mkdir -p free-$(VER)
	cp -p Makefile README LICENSE free.c free.h free-$(VER)
	tar -cvf - free-$(VER) | gzip -9c > free-$(VER).tar.gz
	rm -rf free-$(VER)