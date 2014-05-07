if ! which tmux > /dev/null; then
  yum install gcc kernel-devel make ncurses-devel -y

  mkdir tmp
  cd tmp
  rm -rf libevent-2.0.21-stable
  curl -O -L https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
  tar xzvf libevent-2.0.21-stable.tar.gz
  cd libevent-2.0.21-stable
  ./configure --prefix=/usr/local
  make && make install
  cd ..

  rm -rf tmux
  curl -O -L http://jaist.dl.sourceforge.net/project/tmux/tmux/tmux-1.9/tmux-1.9a.tar.gz
  tar xzvf tmux-1.9a.tar.gz
  cd tmux-1.9a
  LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
  make && make install

  cd ..
  rm -rf tmp
fi
