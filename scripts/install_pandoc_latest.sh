#!/bin/sh
set -e

# Note that 'default' pandoc version means the version bundled with RStudio
# if RStudio is installed , but latest otherwise

PANDOC_VERSION="default"

apt-get update && apt-get -y install wget

if [ -x "$(command -v pandoc)" ]; then
  INSTALLED_PANDOC=$(pandoc --version 2>/dev/null | head -n 1 | grep -oP '[\d\.]+$')
fi

if [ "$INSTALLED_PANDOC" != "$PANDOC_VERSION" ]; then
      PANDOC_DL_URL=$(wget -qO- https://api.github.com/repos/jgm/pandoc/releases/latest | grep -oP "(?<=\"browser_download_url\":\s\")https.*amd64\.deb")
      wget ${PANDOC_DL_URL} -O pandoc-amd64.deb
      rm -f $(which pandoc)
    dpkg -i pandoc-amd64.deb
    rm pandoc-amd64.deb

  ## Symlink pandoc & standard pandoc templates for use system-wide
  PANDOC_TEMPLATES_VERSION=`pandoc -v | grep -oP "(?<=pandoc\s)[0-9\.]+$"`
  wget https://github.com/jgm/pandoc-templates/archive/${PANDOC_TEMPLATES_VERSION}.tar.gz -O pandoc-templates.tar.gz
  rm -fr /opt/pandoc/templates
  mkdir -p /opt/pandoc/templates
  tar xvf pandoc-templates.tar.gz
  cp -r pandoc-templates*/* /opt/pandoc/templates && rm -rf pandoc-templates*
  rm -fr /root/.pandoc
  mkdir /root/.pandoc && ln -s /opt/pandoc/templates /root/.pandoc/templates
fi
