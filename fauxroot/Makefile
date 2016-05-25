
CONFIG=		fauxroot.hints fauxroot.key fauxroot.mkeys \
		unbound.conf named.conf
BASE=		https://icksk.dnssek.info
HOLDDOWN=	175

all:

install: $(CONFIG)
	
fauxroot.hints:
	curl -o $@ $(BASE)/root.hints

fauxroot.key:
	curl -o $@ $(BASE)/unbound.root.key

fauxroot.mkeys: fauxroot.key
	perl ../managed-keys.pl < $< > $@

unbound.conf: unbound.conf.template
	sed \
		-e "s,__PATHNAME__,$(CURDIR)," \
		-e "s,__HOLDDOWN__,$(HOLDDOWN)," \
		< $< > $@

named.conf: named.conf.template
	sed \
		-e "s,__PATHNAME__,$(CURDIR)," \
		-e "s,__HOLDDOWN__,$(HOLDDOWN)," \
		< $< > $@
	
test-unbound: $(CONFIG)
	unbound -dv -c ./unbound.conf

test-named: $(CONFIG)
	named -g -c named.conf -T mkeytimers=1/6/180

clean:
	rm -f $(CONFIG) *.mkeys *.jnl
