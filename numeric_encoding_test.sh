#!/bin/bash

. ./numeric_encoding.sh

test_enc()
{
	for (( i=0; i<1000; i++ ));
	do
		local encoded_value=$(enc_num $i);
		local decoded_value=$(dec_num $encoded_value);
		if [ "$i" != "$decoded_value" ]; then 
			echo "ERROR: $i = $encoded_value = $decoded_value" >&2;
		fi;
	done;
}
test_enc;

