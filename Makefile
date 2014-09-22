
LATEST_KEY=	http://keyroll.systems/static/K.+008+24049.key
ROOT_KEY=	keyroll-systems-root.key

fetch:
	curl -o $(ROOT_KEY) $(LATEST_KEY)

clean:
	rm -f $(ROOT_KEY)
