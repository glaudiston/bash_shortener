#!/bin/sh

. ./shortener.sh

test_shortener()
{
	data=$(xxd --ps </dev/random | head);
	local short_key=$(echo "$data" | shortener_create);
	if [ "$short_key" == "" ]; then
		echo "ERROR: empty response" >&2;
	fi;
	recovered=$(shortener_get $short_key);
	if [ "$data" != "$recovered" ]; then
		echo "ERROR: the short_key[$short_key] failed to resolve to the expectd data";
	fi;
}
test_shortener

