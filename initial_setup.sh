#!/bin/sh

sudo pip install robotframework
git clone https://github.com/robotframework/Selenium2Library.git
cd Selenium2Library
sudo python setup.py install

export a=$(uname -m)
rm -r /tmp/chromedriver/

mkdir /tmp/chromedriver/ && wget -O /tmp/chromedriver/LATEST_RELEASE http://chromedriver.storage.googleapis.com/LATEST_RELEASE && if [ "$a" = "i686" ]; then b=32; elif [ "$a" = "x86_64" ]; then b=64; fi 

latest=$(cat /tmp/chromedriver/LATEST_RELEASE)  

wget -O /tmp/chromedriver/chromedriver.zip 'http://chromedriver.storage.googleapis.com/'$latest'/chromedriver_linux'$b'.zip' 

sudo unzip -o /tmp/chromedriver/chromedriver.zip chromedriver -d /usr/local/bin/ 

sudo apt-get install -y libnss3 libgconf-2-4

sudo chmod u+x /usr/local/bin/chromedriver

case "$(pidof chromedriver | wc -w)" in

0)  echo "Restarting chromedriver:"
    /usr/local/bin/chromedriver &
    ;;
1)  echo "chromedriver already running"
    ;;
esac

