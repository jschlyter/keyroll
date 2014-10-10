# Key Roller Demo

- http://keyroll.systems/

## Setup

    make install
    
## Testing with ISC BIND

**Note:** BIND will listen on port 5301

    make test-named

## Testing with Unbound

**Note:** Unbound will listen on port 5302

    make test-unbound
