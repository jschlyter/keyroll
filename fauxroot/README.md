# Key Roller Demo

RFC5011 KSK roll with new KSK every 90 seconds using https://icksk.dnssek.info/fauxroot.html.

## Setup

    make install

## Testing with ISC BIND

**Note:** BIND will listen on port 5301

    make test-named

## Testing with Unbound

**Note:** Unbound will listen on port 5302

    make test-unbound
