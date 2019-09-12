set -ex

sudo apt install autotools-dev binutils gcc libc6-dev libpam-dev \
 libx11-dev libxcomposite-dev libxext-dev libxfixes-dev libxft-dev \
 libxmuu-dev libxrandr-dev libxss-dev make pkg-config x11proto-core-dev \
 xss-lock

rm -rf xsecurelock
git clone https://github.com/google/xsecurelock.git
cd xsecurelock
sh autogen.sh
./configure --with-pam-service-name=common-auth
make
sudo make install
