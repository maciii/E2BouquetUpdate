#!/bin/sh
#set -x
#exec > /var/volatile/log/Enigma2_Bouquet_Picon_Update.log 2>&1
#DESCRIPTION = Downloads, Installs & Reloads the latest Enigma2 Bouquets, Picons & Encoding

#Transfer script to /usr/script and chmod 755
#A log file will be created in /var/log

#Colors for text

RED='\c00??0000'
GREEN='\c0000??00'
YELLOW='\c00????00'
BLUE='\c0000????'
PURPLE='\c00?:55>7'
WHITE='\c00??????'

#Change the URL to point to your Bouquet tar.gz file
BQ="https://github.com/maciii/E2BouquetUpdate/releases/download/v1.0/enigma2.tar"
BP="https://github.com/maciii/E2BouquetUpdate/releases/download/v1.0/picon.tar.gz"
BE="https://github.com/maciii/E2BouquetUpdate/releases/download/v1.0/encoding.tar.gz"

echo $YELLOW
echo "Please be patient, this process will take a little moment ;)."
#sleep 3
echo "OK, now the update starts."
echo $PURPLE
echo "Please wait..."
echo $WHITE
sleep 3


## Bouquet Download & Installation ##
cd /tmp
wget $BQ
chmod 755 /tmp/enigma2.tar.gz
if find /tmp/enigma2.tar.gz; then
tar -xzvf enigma2.tar.gz

cd /tmp/enigma2
rm -rf /etc/tuxbox/satellites.xml
cp /tmp/enigma2/satellites.xml /etc/tuxbox
cd /etc/tuxbox
chmod 755 satellites.xml

cd /etc/enigma2
rm -rf *.tv
rm -rf *.radio
rm -rf blacklist
rm -rf lamedb
rm -rf cables.xml
rm -rf satellites.xml
rm -rf terrestrial.xml
rm -rf SHOUTcast.favorites
mv /tmp/enigma2/* /etc/enigma2
cd /etc/enigma2
chmod 755 satellites.xml

rm -rf /tmp/enigma2.tar.gz
rm -rf /tmp/enigma2

echo
echo $GREEN
echo "Enigma2 Setting is updated."
echo $WHITE
sleep 3

else

echo $RED
echo "Error: Server is not available..."
echo "Please wait..."
echo $WHITE
sleep 1

fi
## Picon Download & Installation ##
cd /usr/share/enigma2/picon
rm -rf *.png
rm -rf *.db
sleep 1
cd /tmp
wget $BP
chmod 755 /tmp/picon.tar.gz
if find /tmp/picon.tar.gz; then
tar -xzvf picon.tar.gz
rm -rf /usr/share/enigma2/picon
mv /tmp/picon /usr/share/enigma2
chmod 755 /usr/share/enigma2/picon

rm -rf /tmp/picon.tar.gz
rm -rf /tmp/picon
cd /usr/share/enigma2/picon
rm -rf *db

echo
echo $GREEN
echo "Picons are updated."
echo $WHITE
sleep 3

else

echo $RED
echo "Error: Server is not available..."
echo "Please wait..."
echo $WHITE
sleep 1

fi
## Encoding Download & Installation ##
# cd /tmp
# wget $BE
# chmod 755 /tmp/encoding.tar.gz
# if find /tmp/encoding.tar.gz; then
# tar -xzvf encoding.tar.gz
#
# rm -rf /usr/share/enigma2/encoding.conf
# mv /tmp/encoding.conf /usr/share/enigma2
#
# rm -rf /tmp/encoding.tar.gz
# rm -rf /tmp/encoding.conf
#
# echo
# echo $GREEN
# echo "Encoding is updated."
# echo $WHITE
# echo
# echo
# sleep 3

## Reload Settings & Restart BOX ##
sleep 2
echo $GREEN
echo "Done! :) Your BOX is now going to GUI restart."
sleep 2
echo $YELLOW
echo "Please wait for GUI restart."
sleep 4
killall -9 enigma2

else

echo $RED
echo "Error: Server is not available..."
sleep 2
echo
echo $PURPLE
echo "It's likely that the update server is unavailable..."
sleep 3
echo "...or Your BOX is not connected to the network."
sleep 2
echo $YELLOW
echo "Please check your network connection or try repeating the process later."
echo
echo $GREEN "Now press >>"$YELLOW" OK "$GREEN"<< or >>"$YELLOW" Exit "$GREEN"<< key."
fi
exit
