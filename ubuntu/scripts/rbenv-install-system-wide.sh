#!/bin/bash

# Install rbenv
if [ ! -d "/usr/local/rbenv" ]; then
  git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv

  # Add rbenv to the path:
  echo '# rbenv setup' > /root/.bashrc
  echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc
  echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /root/.bashrc
  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

  source /root/.bashrc

  # Install ruby-build:
  pushd /tmp
    git clone git://github.com/sstephenson/ruby-build.git
    cd ruby-build
    ./install.sh
  popd
fi

