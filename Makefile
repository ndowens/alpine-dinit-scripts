PREFIX	?= /usr
SYSCONFDIR    ?= /etc
LOCALSTATEDIR ?= /var
BINDIR        ?= $(PREFIX)/bin
LIBDIR        ?= $(PREFIX)/lib
DATADIR       ?= $(PREFIX)/share
MANDIR        ?= $(DATADIR)/man/man8
DINITDIR      ?= $(SYSCONFDIR)/dinit.d

BIN_PROGRAMS = modules-load

all:
	@echo "Nothing to build"
	@echo "run make install"

SERVICES = \
	mount-all \
	udev-settle \
	sddm \
	single \
	binfmt \
	tty4 \
	setup \
	cgroups \
	misc \
	cleanup \
	kmod-static-nodes \
	net-lo \
	tty3 \
	tty1 \
	sysctl \
	vconsole \
	mount \
	pseudofs \
	udev-trigger \
	boot \
	tmpfs \
	recovery \
	udevd \
	hwclock \
	tty5 \
	hostname \
	getty \
	tty2 \
	modules \
	dmesg \
	tty6 \
	fsck \
	udhcpc \
	loginready

CONF_FILES = \
	cgroups.conf \
	hwclock.conf \
	rc.local \
	rc.shutdown

SERVICEDIR = boot.d \
	mount.d \
	getty.d

MANPAGES = modules-load.8

SCRIPTS = \
	  binfmt \
	  cgroup-release-agent.sh \
	  cgroups  \
	  cleanup  \
	  dmesg  \
	  hostname \
	  hwclock  \
	  mount-all  \
	  pseudofs  \
	  root-rw  \
	  udhcpc  \
	  vconsole

install:
	install -d $(DESTDIR)$(BINDIR)
	install -d $(DESTDIR)$(DATADIR)
	install -d $(DESTDIR)$(SYSCONFDIR)
	install -d $(DESTDIR)$(MANDIR)
	install -d $(DESTDIR)$(DINITDIR)
	install -d $(DESTDIR)$(DINITDIR)/config
	install -d $(DESTDIR)$(DINITDIR)/scripts
	install -d $(DESTDIR)$(DINITDIR)/boot.d
	install -d $(DESTDIR)$(DINITDIR)/mount.d
	install -d $(DESTDIR)$(DINITDIR)/getty.d
	install -d $(DESTDIR)$(LOCALSTATEDIR)/log/dinit
	
	# placeholder
	touch $(DESTDIR)$(DINITDIR)/mount.d/.KEEP
	touch $(DESTDIR)$(DINITDIR)/boot.d/.KEEP
	
	# config files
	for conf in $(CONF_FILES); do \
		install -m 644 config/$$conf $(DESTDIR)$(DINITDIR)/config; \
	done
	
	# scripts
	for script in $(SCRIPTS); do \
		install -m 755 scripts/$$script $(DESTDIR)$(DINITDIR)/scripts; \
	done
	
	# programs
	for prog in $(BIN_PROGRAMS); do \
		install -m 755 $$prog $(DESTDIR)$(BINDIR); \
	done

	# manpages
	for man in $(MANPAGES); do \
		install -m 644 $$man $(DESTDIR)$(MANDIR); \
	done

	# services
	for srv in $(SERVICES); do \
		install -m 644 $$srv $(DESTDIR)$(DINITDIR); \
	done
