#!/bin/sh -e
hostname=$1
device=$2

if [ -z "$hostname" -o -z "$token" ]; then
	echo "Usage: token=<your-authentication-token> [netmask=64] $0 your-name.dynv6.net [device]"
	exit 1
fi

if [ -z "$netmask" ]; then
	netmask=128
fi

if [ -n "$device" ]; then
	device="dev $device"
fi
address=$(ip -6 addr list scope global $device | grep -v " fd" | sed -n 's/.*inet6 \([0-9a-f:]\+\).*/\1/p' | head -n 1)

if [ -e /usr/bin/curl ]; then
	bin="curl -fsS"
elif [ -e /usr/bin/wget ]; then
	bin="wget -O-"
else
	echo "neither curl nor wget found"
	exit 1
fi

if [ -z "$address" ]; then
	echo "no IPv6 address found"
	exit 1
fi

# address with netmask
current=$address/$netmask
echo "updating with: $current"

# send addresses to dynv6
current="2001:9e8:1801:7b00:bef1:1022:2c6:29d0/$netmask"
echo "updating with: $current"
$bin "http://dynv6.com/api/update?hostname=$hostname&ipv6=$current&token=$token"
$bin "http://ipv4.dynv6.com/api/update?hostname=$hostname&ipv4=auto&token=$token"
