#!/bin/sh

## The shell in the go-ipfs container is busybox, so a version of ash
## Shellcheck might warn on things POSIX sh cant do, but ash can
## In Shellcheck, ash is an alias for dash, but busybox ash can do more than dash 
## https://github.com/koalaman/shellcheck/blob/master/src/ShellCheck/Data.hs#L134

## Uncomment this section to customise the gateway configuration
# echo "ipfs-config: setting Gateway config"
# ipfs config --json Gateway '{
#         "HTTPHeaders": {
#             "Access-Control-Allow-Origin": [
#                 "*"
#             ],
#         }
#     }'
## Obviously you should use your own domains here, but I thought it instructive to show path and 
## subdomain gateways here with the widely known PL domains

## Disable hole punchibng
ipfs config --json Swarm.EnableHolePunching false
ipfs config --json Swarm.RelayClient.Enabled false

## Bind API to all interfaces so that fly proxy for the Kubo API works
ipfs config Addresses.API --json '["/ip4/0.0.0.0/tcp/5001", "/ip6/::/tcp/5001"]'

## Maybe you need to listen on IPv6 too? Some clouds use it for internal networking
#ipfs config --json Addresses.Gateway '["/ip4/0.0.0.0/tcp/8080","/ip6/::/tcp/8080"]'

## In fly.io there's no way to know the public IPv4 so it has to be manually configured to be announced
## Note that it must be 1-1, you can't point at multiple go-ipfs nodes and expect it to work
# echo "ipfs-config: setting Addresses.AppendAnnounce config"
# TODO: Enable this line with the IPv4 of the 
# ipfs config --json Addresses.AppendAnnounce '["/ip4/[ADD_IP_V4_HERE]/tcp/4001"]'