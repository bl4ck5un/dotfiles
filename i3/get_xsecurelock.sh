git clone https://github.com/google/xsecurelock.git
cd xsecurelock
sh autogen.sh
./configure --with-pam-service-name=common-auth
make
sudo make install

rm -rf xsecurelock
