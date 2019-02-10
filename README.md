# Scratch Arcade Setup

Last update: 10/02/2019

This guide describes how you can setup a Raspberry Pi 3B(+) to run as a Scratch
arcade. The required hardware can be found in the HARDWARE.md file, but a keyboard
will work as well if you don't have arcade buttons & a controller board at hand.

## Manual part of the installation

First you need to prepare an SD card with Raspbian Lite. Download the image from
https://www.raspberrypi.org/downloads/raspbian/ and follow the instructions
specified in the [installing images](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)
documentation.

Once you have the SD card, you can boot the Raspberry Pi (make sure you
connect a keyboard and screen for now). You can login with the default user
**pi** and password **raspberry**.

You should now see the default prompt :
```
pi@raspberrypi:~ $
```

Execute the following command :
```
sudo raspi-config
```

First make sure the keyboard layout matches your keyboard (you can skip this part
if you are using a UK-English keyboard).

Select option 4 (Localisation Options) from the menu and next select option I3
(Change Keyboard Layout) to select your keyboard layout. Generic 105-key (Intl)
PC should work for most keyboards.

After selecting your keyboard layout you can probably accept the defaults in
the next dialogs, until you get back to the main menu.

Next we will enable SSH access, so we can configure the Raspberry Pi remotely.
To do this, select option 5 (Interfacing Options) from the main menu and next
select option P2 (SSH). Select Yes in the dialog to enable SSH.

Finally, we'll setup networking. To this select option 2 in the main menu
(Network Options) and next select N2 (Wi-Fi).

Pick your country code and enter the SSID and password for your WiFi.

Once these are set select Finish in the main menu to close raspi-config.

Execute the following command to restart the networking service :
```
sudo systemctl restart networking
```

And next :
```
ip addr
```

If everything went ok you should now see an IP address on your local network
next to the wlan0 device :
```
pi@raspberrypi:~ $ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.113/24 brd 192.168.1.255 scope global wlan0
       valid_lft forever preferred_lft forever
    inet6 fe80::2d1:1555:5370:79b6/64 scope link
       valid_lft forever preferred_lft forever
```

Test of SSH works from a different computer :
ssh pi@*ip of wlan0* (so, for the example above this would be
`ssh pi@192.168.1.113`).

You should now see something like this :
```
The authenticity of host '192.168.1.113 (192.168.1.113)' can't be established.
ECDSA key fingerprint is ... .
Are you sure you want to continue connecting (yes/no)?
```
Just reply **yes** to open the connection.

You should now see the default prompt :
```
pi@raspberrypi:~ $
```

If everything went ok, you can continue with the rest of the installation.


## Installing the Scratch arcade

**NOTE:** All of the commands that follow have to be executed on the Raspberry
Pi. You can either use SSH (as described above) or open a console session and use
the keyboard connected to the Raspberry Pi to enter them.

First we need to install some tools that are needed for the installation scripts,
so run the following command :
```
sudo apt-get install -y ansible git sshpass
```

Now you can install the installation scripts from our GitHub repository, by
executing :
```
git clone https://github.com/tienen-coderdojo/scratch-arcade-setup.git
```

This will create a scratch-arcade-setup folder. Navigate to the ansible folder
(**cd scratch-arcade-setup/ansible**) and copy the **hosts.dist** and
**vars.yml.dist** files to **hosts** and **vars.yml** respectively).

Execute :
```
cp hosts.dist hosts
cp vars.yml.dist vars.yml
```

You can modify these files when needed before executing the rest of the setup
(more information on the things you can change will follow at a later time).

## Automated part of the setup

The foregoing was the "difficult" part of the installation, the rest of the setup
is for the largest part automated via Ansible.

Run the arcade setup script :
```
./setup-arcade.sh
```

This will install all required software. When the installation is complete,
you should copy the HTML files for the arcade over to the /home/pi/html folder
(an example will be provided later).

And finally you can reboot the Raspberry Pi to check if everything works :
```
sudo reboot
```

The Raspberry Pi should boot up with Chromium running in kiosk mode on
http://localhost/index.html ...

## Optionally : setup the Raspberry Pi as a wireless access point

**NOTE:** As this will change the wireless settings on your Raspberry Pi you
have to execute the following commands on a console (via a keyboard attached
to your Raspberry Pi). If you do it over SSH, you will lose the connection...

As our Raspberry Pi will be inside a real arcade cabinet and we want to make
updates as easy as possible, we also provide a script to setup the Raspberry
Pi as a wireless access point. This will allow us to easily update the Arcade
files using a WiFi connection.

First setup the SSID, wireless channel and password you want to use in the
vars.yml file. Next, execute the following command to setup the wireless AP :
```
ansible-playbook -s -i hosts wireless-ap.yml
```

Once the setup is finished you should restart the Raspberry Pi and once it has
booted you should be able to access it when you connect your wireless to the
SSID you set in the configuration by running :
```
ssh pi@192.168.0.10
```

**NOTE:** Once the Raspberry Pi has been setup as wireless access point it
will no longer have access to the Internet (unless you use a wired connection)!
