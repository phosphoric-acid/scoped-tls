
## common makefile for building rusty libraries

PREFIX ?= /usr/local
LIBDIR ?= $(PREFIX)/lib
RUSTC  ?= rustc

RUST_LIBDIR ?= $(LIBDIR)

TARGET_RLIB=lib$(CRATE_NAME).rlib
TARGET_SO=lib$(CRATE_NAME).so.$(SO_MAJOR).$(SO_MINOR).$(SO_PATCH)
TARGET_SO_LINK=lib$(CRATE_NAME).so

all:	$(TARGET_RLIB) $(TARGET_SO) $(TARGET_SO_LINK)

$(TARGET_RLIB):	$(SRCS)
	$(RUSTC) $(MAIN_SRC) --crate-type=rlib --crate-name $(CRATE_NAME) -o $@

$(TARGET_SO):	$(SRCS)
	$(RUSTC) $(MAIN_SRC) --crate-type=dylib --crate-name $(CRATE_NAME) -o $@

$(TARGET_SO_LINK):	$(TARGET_SO)
	ln -s $(TARGET_SO) $(TARGET_SO_LINK)

install:	$(TARGET_RLIB) $(TARGET_SO) $(TARGET_SO_LINK)
	mkdir -p $(DESTDIR)/$(LIBDIR)
	cp -d -p $(TARGET_RLIB) $(TARGET_SO) $(TARGET_SO_LINK) $(DESTDIR)/$(RUST_LIBDIR)

clean:
	rm -f $(TARGET_RLIB) $(TARGET_SO) $(TARGET_SO_LINK)
