#!/bin/sh
. ./numeric_encoding.sh
shortener_init()
{
	mkdir -p data/{key,hash};
	next_value=$(ls -1 data/key| sort -n | tail -1);
	let next_value++;
}
shortener_init;
shortener_create()
{
	local v=$(base64 -w0); # we need b64 because bash can not handle binary as variables can not have NULL bytes
	local h=$(echo $v | md5sum | cut -d " " -f1)
	ls data/hash/$h 2>/dev/null && {
		echo "already exists" >&2;
		cat data/hash/$h;
		return;
	}
	local k=$next_value;
	echo "$v" > data/key/$k;
	printf $k > data/hash/$h;
	let next_value++;
	enc_num $k;
}
shortener_get()
{
	local k=$(dec_num $1);
	cat data/key/$k | base64 -d;
}
