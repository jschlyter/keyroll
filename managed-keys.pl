#!/usr/bin/perl

while (<>) {
    chomp;
    s/\s*;.*$//;
    if (/^\.\s*\d*\s+IN\s+DNSKEY\s+(\d+)\s+(\d+)\s+(\d+)\s+(.+)$/) {
        print "managed-keys {\n";
        print "  . initial-key $1 $2 $3 \"$4\";\n";
        print "};\n";
    }
}
