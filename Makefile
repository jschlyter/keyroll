
SUDO=		sudo
LATEST_KEY=	http://keyroll.systems/current.key
ROOT_KEY=	keyroll-systems-root.key
ROOT_ZONE=	keyroll-systems-root.zone
NAMED_KEYS=	named-keys.conf

all:

fetch:
	curl -o $(ROOT_KEY) $(LATEST_KEY)

$(ROOT_KEY): fetch

$(NAMED_KEYS): $(ROOT_KEY)
	perl managed-keys.pl < $(ROOT_KEY) > $@

install-named: $(NAMED_KEYS)
	$(SUDO) install -m 444 $(ROOT_ZONE) /var/named
	$(SUDO) install -m 644 $(NAMED_KEYS) /var/named/keys.conf

clean-named:
	$(SUDO) rm -f /var/named/*.mkeys{,.jnl}

install-unbound: $(ROOT_KEY)
	$(SUDO) install -m 444 $(ROOT_ZONE) /var/unbound
	$(SUDO) install -m 644 $(ROOT_KEY) /var/unbound	

clean:
	rm -f $(ROOT_KEY) $(NAMED_KEYS)
