
SUDO=		sudo
LATEST_KEY=	http://keyroll.systems/current.key
ROOT_KEY=	keyroll-systems-root.key
ROOT_ZONE=	keyroll-systems-root.zone
NAMED_KEYS=	named-keys.conf

NAMED_DEST=	/var/tmp/keyroll-named
UNBOUND_DEST=	/var/tmp/keyroll-unbound

NAMED=		/usr/local/sbin/named
UNBOUND=	/usr/local/sbin/unbound


all:

fetch:
	curl -o $(ROOT_KEY) $(LATEST_KEY)

$(ROOT_KEY): fetch

$(NAMED_KEYS): $(ROOT_KEY)
	perl managed-keys.pl < $(ROOT_KEY) > $@

install: install-named-conf install-unbound-conf

clean:
	rm -f $(ROOT_KEY) $(NAMED_KEYS)
	rm -fr $(NAMED_DEST)
	rm -fr $(UNBOUND_DEST)
	
	
install-named-conf: $(NAMED_DEST)/$(ROOT_ZONE) $(NAMED_DEST)/$(NAMED_KEYS)
	
$(NAMED_DEST)/$(ROOT_ZONE): $(ROOT_ZONE)
	install -d $(NAMED_DEST)
	install -m 444 $(ROOT_ZONE) $(NAMED_DEST)

$(NAMED_DEST)/$(NAMED_KEYS): $(NAMED_KEYS)
	install -d $(NAMED_DEST)
	install -m 644 $(NAMED_KEYS) $(NAMED_DEST)/keys.conf

test-named: $(NAMED_DEST)/$(ROOT_ZONE) $(NAMED_DEST)/$(NAMED_KEYS)
	$(SUDO) $(NAMED) -g -c named.conf
	
clean-named:
	$(SUDO) rm -f /var/named/*.mkeys{,.jnl}


install-unbound-conf: $(UNBOUND_DEST)/$(ROOT_ZONE) $(UNBOUND_DEST)/$(ROOT_KEY)

$(UNBOUND_DEST)/$(ROOT_ZONE): $(ROOT_ZONE)	
	install -d $(UNBOUND_DEST)
	install -m 444 $(ROOT_ZONE) $(UNBOUND_DEST)

$(UNBOUND_DEST)/$(ROOT_KEY): $(ROOT_KEY)
	install -d $(UNBOUND_DEST)
	install -m 644 $(ROOT_KEY) $(UNBOUND_DEST)

test-unbound: $(UNBOUND_DEST)/$(ROOT_ZONE) $(UNBOUND_DEST)/$(ROOT_KEY)
	$(SUDO) $(UNBOUND) -dv -c unbound.conf
