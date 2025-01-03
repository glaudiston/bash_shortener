#!/bin/sh
declare -a enc_charset=( a b c d e f g h i j k l m n o p r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 _ - );
declare charset_length=${#enc_charset[@]};

charset_index_of()
{
	local c=$1;
	local idx=$2;
	[ ${idx:=0} -ge $charset_length ] && return;
	[ ${enc_charset[$idx]} == $c ] && { printf $idx; return; };
	charset_index_of $c $((idx+1));
}

enc_num()
{
	local value=$1
	local char_value=$(( value % charset_length ));
	local remain=$(( (value - char_value) / charset_length ));
	if [ $remain -gt 0 ]; then
		enc_num $remain;
	fi;
	printf ${enc_charset[$char_value]};
}
dec_num()
{
	declare -a encoded_value=( $(echo -n $1 | fold -w1 | tr '\n' ' ') );
	local encoded_length="${#encoded_value[@]}"
	[ "$encoded_length" == 0 ] && { printf 0; return; };
	local value=$(( $(charset_index_of ${encoded_value[0]}) * (charset_length ** (encoded_length-1)) + $(dec_num ${1:1}) ))
	printf $value;
}

