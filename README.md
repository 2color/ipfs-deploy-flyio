# Deploying an IPFS node (Kubo) to fly.io

## 1. Clone this repo and enter the folder

```sh
git clone git@github.com:2color/ipfs-deploy-flyio.git

cd ipfs-deploy-flyio
```

## 2. Create the fly app

```sh
fly launch --copy-config
```

Give the app a name when promoted.

## 3. Create fly volume

```sh
fly volumes create ipfs_data --size 20
```

## 4. Get the IPv4 of the container and update it in `ipfs-config.sh`

To get the IPv4 of the container, run the following command:

```sh
fly ips list
```

Open [`ipfs-config.sh`](./ipfs-config.sh), uncomment the last line, and add the IPv4 from the step above:

```
ipfs config --json Addresses.AppendAnnounce '["/ip4/[ADD_IP_V4_HERE]/tcp/4001"]'
```

## 5. Deploy the app again

To ensure that the Kubo node is deployed with the updated configuration,

```sh
fly deploy
```

## 6. Use fly proxy to interact with the Kubo RPC API

To open a proxy to the Kubo node, run the following comand:

```sh
fly proxy 5001:5001
```

Run the ipfs CLI against the deployed Kubo node:

```sh
ipfs id --api /ip4/127.0.0.1/tcp/5001/api
```
