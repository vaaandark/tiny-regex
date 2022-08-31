CC=gcc
#SANITIZE=-fsanitize=address
CFLAGS=-Wall -Wextra -Werror -Wshadow $(SANITIZE) -g -O2
SOURCEDIR=src
BUILDDIR=build
OBJECTS=$(BUILDDIR)/re.o $(BUILDDIR)/NFA.o $(BUILDDIR)/irregex.o

all: $(OBJECTS) $(BUILDDIR)/main.o $(BUILDDIR)/re2tree.o $(BUILDDIR)/re2graph.o $(BUILDDIR)/lex.o
	$(CC) $(CFLAGS) $(OBJECTS) $(BUILDDIR)/main.o -o $(BUILDDIR)/irregex
	$(CC) $(CFLAGS) $(OBJECTS) $(BUILDDIR)/re2tree.o -o $(BUILDDIR)/re2tree
	$(CC) $(CFLAGS) $(OBJECTS) $(BUILDDIR)/re2graph.o -o $(BUILDDIR)/re2graph
	$(CC) $(CFLAGS) $(OBJECTS) $(BUILDDIR)/lex.o -o $(BUILDDIR)/lex

$(BUILDDIR)/re.o: $(SOURCEDIR)/def.h
	$(CC) $(CFLAGS) -c $(SOURCEDIR)/re.c -o $(BUILDDIR)/re.o

$(BUILDDIR)/NFA.o: $(SOURCEDIR)/re.h
	$(CC) $(CFLAGS) -c $(SOURCEDIR)/NFA.c -o $(BUILDDIR)/NFA.o

$(BUILDDIR)/irregex.o: $(SOURCEDIR)/NFA.h
	$(CC) $(CFLAGS) -c $(SOURCEDIR)/irregex.c -o $(BUILDDIR)/irregex.o

$(BUILDDIR)/main.o: $(SOURCEDIR)/irregex.h
	$(CC) $(CFLAGS) -c $(SOURCEDIR)/main.c -o $(BUILDDIR)/main.o

$(BUILDDIR)/re2tree.o: $(SOURCEDIR)/NFA.h
	$(CC) $(CFLAGS) -c $(SOURCEDIR)/re2tree.c -o $(BUILDDIR)/re2tree.o

$(BUILDDIR)/re2graph.o: $(SOURCEDIR)/NFA.h
	$(CC) $(CFLAGS) -c $(SOURCEDIR)/re2graph.c -o $(BUILDDIR)/re2graph.o

$(BUILDDIR)/lex.o: $(SOURCEDIR)/irregex.h
	$(CC) $(CFLAGS) -c $(SOURCEDIR)/lex.c -o $(BUILDDIR)/lex.o

.PHONY: clean
clean:
	-rm -rf $(OBJECTS) \
		$(BUILDDIR)/re2graph.o $(BUILDDIR)/re2tree.o $(BUILDDIR)/irregex.o \
		$(BUILDDIR)/lex.o $(BUILDDIR)/main.o $(BUILDDIR)/irregex $(BUILDDIR)/re2graph \
		$(BUILDDIR)/re2tree $(BUILDDIR)/lex

