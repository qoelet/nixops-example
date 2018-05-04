# NixOps example

## Goals

- Build a simple web application that says "hello, world"
- Want this deployed to an EC2 instance

## Pre-reqs

- Have AWS credentials saved to `~/.aws/credentials` with a profile name `[example]`
- Have a security group in AWS with group id "test" configured for SSH (and for the purpose of this example, port 8080)

```console
$ nixops create config.nix ec2.nix -d test
created deployment ‘54ffa951-4f73-11e8-a9ea-3c970ed87d99’
54ffa951-4f73-11e8-a9ea-3c970ed87d99

$ nixops list
+--------------------------------------+------+-------------+------------+------+
| UUID                                 | Name | Description | # Machines | Type |
+--------------------------------------+------+-------------+------------+------+
| 54ffa951-4f73-11e8-a9ea-3c970ed87d99 | test | Example     |          1 | ec2  |
+--------------------------------------+------+-------------+------------+------+

$ nixops deploy -d test # this can take a while...
my-key-pair.> uploading EC2 key pair ‘charon-54ffa951-4f73-11e8-a9ea-3c970ed87d99-my-key-pair’...
testInstance> creating EC2 instance (AMI ‘ami-84bccff8’, type ‘t2.micro’, region ‘ap-southeast-1’)...
testInstance> waiting for IP address... [pending] [pending] [pending] [pending] [pending] [pending] [running] 13.229.73.248 / 172.31.11.76
testInstance> waiting for SSH.........
testInstance> replacing temporary host key...
testInstance> setting state version to 17.09
building all machine configurations...
...
testInstance> activating the configuration...
testInstance> setting up /etc...
testInstance> restarting systemd...
testInstance> setting up tmpfiles
testInstance> reloading the following units: dbus.service, dev-hugepages.mount, dev-mqueue.mount, sys-fs-fuse-connections.mount, sys-kernel-debug.mount
testInstance> restarting the following units: dhcpcd.service, sshd.service, systemd-journald.service
testInstance> starting the following units: apply-ec2-data.service, audit.service, kmod-static-nodes.service, network-local-commands.service, network-setup.service, nix-daemon.socket, nscd.service, print-host-key.service, rngd.service, systemd-journal-catalog-update.service, systemd-modules-load.service, systemd-sysctl.service, systemd-timesyncd.service, systemd-tmpfiles-clean.timer, systemd-tmpfiles-setup-dev.service, systemd-udev-trigger.service, systemd-udevd-control.socket, systemd-udevd-kernel.socket
testInstance> activation finished successfully
test> deployment finished successfully

$ nixops ssh testInstance

root@testInstance:~]#
● myApp.service
   Loaded: loaded (/nix/store/jhvqy7sdxsv7h98gkkwkd1i1yc5yvqsc-unit-myApp.service/myApp.service; enabled; vendor preset: en
   Active: active (running) since Fri 2018-05-04 09:07:42 UTC; 7s ago
 Main PID: 4401 (nixops-example)
    Tasks: 5 (limit: 4915)
   CGroup: /system.slice/myApp.service
           └─4401 /nix/store/fq9p41y19v8wdv9za6hcnd4zighjmm1y-nixops-example-1.0.0/bin/nixops-example

May 04 09:07:42 testInstance systemd[1]: Started myApp.service.

[root@testInstance:~]# exit

$ curl 13.229.73.248:8080
hello, world!

$ nixops destroy -d test
warning: are you sure you want to destroy EC2 machine ‘testInstance’? (y/N) y
testInstance> destroying EC2 machine... [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [shutting-down] [terminated]
warning: are you sure you want to destroy keypair ‘charon-54ffa951-4f73-11e8-a9ea-3c970ed87d99-my-key-pair’? (y/N) y
my-key-pair.> deleting EC2 key pair ‘charon-54ffa951-4f73-11e8-a9ea-3c970ed87d99-my-key-pair’...
```
