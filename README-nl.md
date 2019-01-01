# Setup voor Scratch arcade kasten

Laatste update: 01/01/2019

Deze handleiding beschrijft hoe je een Raspberry Pi kan opzetten als Scratch
arcade machine. De benodigde hardware staat beschreven in het HARDWARE-nl.md
bestand, maar je kan uiteraard ook testen met een keyboard als je deze hardware
nog niet zou hebben.

## Manuele deel van de setup

Eerst en vooral moet je een SD card maken met Raspbian Lite erop. Download deze
image van https://www.raspberrypi.org/downloads/raspbian/ en volg daarna de
instructies van de [installing images](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)
documentatie om de image op een SD card te zetten.

Na deze setup kan je de Raspberry Pi booten (zorg dat je er op z'n minst een
keyboard en een scherm aan hangt) en inloggen met de default user **pi** en
paswoord **raspberry**.

Alles alles hierboven gelukt is zou je nu de default prompt moeten zien :
```
pi@raspberrypi:~ $
```

Voer het volgende commando uit :
```
sudo raspi-config
```

We gaan nu allereerst de keyboard layout correct zetten zodat het invoeren van
paswoorden klopt (standaard staat de keyboard layout op Brits-Engels). Kies dus
voor optie 4 (Localisation Options) en daarna optie I3 (Change Keyboard Layout)
om de gewenste keyboard layout te kiezen.

De Generic 105-key (Intl) PC zou moeten werken voor zowat elk denkbaar keyboard,
maar bij Keyboard layout kies je eerst voor Other, en dan afhankelijk van je
toetsenbord layout ofwel Belgian, Belgian (voor AZERTY met Belgische layout)
ofwel (als je iemand bent die QWERTY verkiest zoals ik) voor English (US),
English (US, with euro on 5) of 1 van de andere varianten die overeenkomt met
jouw keyboard.

Voor de volgende dialoogvensters kan je gewoon de default waardes accepteren tot
je terug op het hoofdmenu terechtkomt.

Vervolgens gaan we de SSH service aanzetten, zodat we van buitenaf op de
Raspberry Pi kunnen connecteren en de rest van de setup geautomatiseerd kan
verlopen. Selecteer hiervoor eerst optie 5 (Interfacing Options) en kies
vervolgens P2 (SSH), en kies voor Yes in de volgende dialoogvenster om de SSH
service aan te zetten.

Tenslotte gaan we networking aanzetten, zodat we de rest van de installatie
kunnen uitvoeren. Kies hiervoor optie 2 (Network Options) en daarna N2 (Wi-Fi).
Kies allereerst het land (voor mij is dat dus BE voor België, Nederlanders kiezen
hier voor NL). Vervolgens zal er gevraagd worden naar de SSID en login gegevens
van je Wi-Fi connectie. Voer deze in en kies daarna Finish onderaan in het
hoofdmenu om raspi-config af te sluiten.

Voer vervolgens volgend commando uit om de networking service te herstarten :
```
sudo systemctl restart networking
```

En daarna :
```
ip addr
```

Als alles goed gegaan is zou je nu een IP adres van je interne netwerk moeten
zien bij de wlan0 device, zoals in onderstaande :

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

Test de SSH connectie uit vanop een andere computer :
ssh pi@*ip van wlan0* (voor het voorbeeld hierboven zou dit dus
ssh pi@192.168.1.113 worden).

Aangezien het de eerte keer is dat je een SSH connectie opent zou je nu iets als
volgt te zien moeten krijgen :
```
The authenticity of host '192.168.1.113 (192.168.1.113)' can't be established.
ECDSA key fingerprint is SHA256:GOGDNhRwvLF3HEIe5XZYoPJqz2U6hoI/HqCF1qLJhfo.
Are you sure you want to continue connecting (yes/no)?
```
Je kan hier simpelweg **yes** antwoorden om de connectie te openen.

Daarna zou je de **pi@raspberrypi:~ $** prompt moeten zien en kan je de volgende
stappen van de setup uitvoeren.
