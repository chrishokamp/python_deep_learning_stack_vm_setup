# Install SSH in case we need it (not necessary for this script)
sudo apt-get install openssh-server 
# for this to work our VM must be configured to forward host port 3333 to local port 22
# to ssh from host to guest VM, do:
# ssh -p 3333 user42@localhost

sudo apt-get install build-essential

# install chrome (because it works well with ipython notebook)
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# Install git
sudo apt-get install git

# install gfortran
sudo apt-get install gfortran

# install openblas
# remove openblas if you installed it
sudo apt-get remove libopenblas-base 
# Download the development version of OpenBLAS
git clone git://github.com/xianyi/OpenBLAS
cd OpenBLAS
make FC=gfortran

mkdir -p $HOME/local/openblas/ 
make PREFIX=$HOME/local/openblas install

# commented for now because of theano+OpenBLAS errors during testing  
#echo "# OpenBLAS" >> ~/.bashrc 
#echo "export LD_LIBRARY_PATH=/usr/local/lib:$HOME/local/openblas/lib" >> ~/.bashrc
  
source ~/.bashrc

cd
echo "Done installing OpenBLAS"

sudo apt-get install libblas-dev liblapack-dev libatlas-base-dev

# install the anaconda python distribution
echo 'grabbing the Anaconda distro, note that you will need to accept the license...' 
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda-2.3.0-Linux-x86_64.sh
bash Anaconda*.sh
cd
source .bashrc
echo "Done installing Anaconda"
  
# install Anaconda, then nltk, theano, fuel, and blocks

# Install bleeding edge theano
git clone git://github.com/Theano/Theano.git
cd Theano
python setup.py develop --user
cd ..

# blocks
# make sure you're using Anaconda or similar

# stable
pip install git+git://github.com/mila-udem/blocks.git \
    -r https://raw.githubusercontent.com/mila-udem/blocks/master/requirements.txt

# now upgrade
pip install git+git://github.com/mila-udem/blocks.git \
    -r https://raw.githubusercontent.com/mila-udem/blocks/master/requirements.txt --upgrade

# install nltk (nltk is included in Anaconda) and all datasets
python -m nltk.downloader all
 
# install gensim 
pip install gensim

# setup theano rc -- this part commented for now because of blas errors
# echo -e "\n[blas]\nldflags = -L/home/$USER/local/openblas -lopenblas\n" >> ~/.theanorc

# make sure we're all up to date
sudo apt-get update

echo "all done, have a great day $USER"

