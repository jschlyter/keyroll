
CONFIG=		fauxroot.hints fauxroot.key unbound.conf
BASE=		https://icksk.dnssek.info
HOLDDOWN=	175

all:

bootstrap: $(CONFIG)
	
fauxroot.hints:
	curl -o $@ $(BASE)/root.hints

fauxroot.key:
	curl -o $@ $(BASE)/unbound.root.key

unbound.conf: unbound.conf.template
	sed \
		-e "s,__PATHNAME__,$(CURDIR)," \
		-e "s,__HOLDDOWN__,$(HOLDDOWN)," \
		< $< > $@
	
test: $(CONFIG)
	unbound -dv -c ./unbound.conf

clean:
	rm -f $(CONFIG)
